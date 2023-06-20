import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:queue/queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_card_provider.g.dart';

/// `DeleteCardController` provides a mechanism to manage card deletions in an
/// Anki session.
///
/// This controller maintains an internal queue of pending deletion requests to
/// the database and provides methods to delete and undo delete operations on
/// AnkiCards.
///
/// It immediately removes the card from the local cache (`cardsListProvider`)
/// upon a deletion request, to give a responsive feel to the user. The actual
/// deletion from the database is then queued and performed asynchronously.
///
/// The controller also remembers the last deleted card, allowing for an undo
/// operation.
@Riverpod(keepAlive: true)
class DeleteCardController extends _$DeleteCardController {
  final _queue = Queue();
  AnkiCard? _lastDeletedCard;

  @override
  void build() {
    return;
  }

  /// Deletes the card.
  ///
  /// This method immediately removes a card with the provided [cardId] from the
  /// `cardsListProvider` from the [sessionId]. It also adds a deletion request
  /// to the internal queue, which is responsible for communicating with the
  /// database to permanently delete the card.
  void delete({
    required CardId cardId,
    required SessionId sessionId,
  }) {
    // Remove card locally first to avoid loading states.
    _lastDeletedCard = ref.read(cardsListProvider.notifier).get(cardId);
    ref.read(cardsListProvider.notifier).remove(cardId);

    _queue.add(
      () async {
        final repository = ref.read(sessionRepositoryProvider);
        ref.read(loggerProvider).v('Delete card "$cardId"');
        await repository.deleteCard(
          sessionId: sessionId,
          cardId: cardId,
        );
      },
    ).catchError((e) {
      if (e is QueueCancelledException) {
        // We ignore this error because it is thrown when the user signs out.
        return;
      }
    });
  }

  /// Undoes the last card deletion.
  ///
  /// This method attempts to undo the most recent card deletion. If the
  /// deletion request is still pending in the queue, it's removed. If not, it
  /// issues an undo request to the database. The card is then readded to the
  /// `cardsListProvider`.
  ///
  /// If there's no card to undo deletion for, it logs a warning and returns
  /// `false`. Otherwise, it returns `true` to indicate success.
  bool undo({
    required SessionId sessionId,
  }) {
    if (_lastDeletedCard == null) {
      ref.read(loggerProvider).w(
          'Could not undo card deletion because there has been no card deleted before');
      return false;
    }

    final id = _lastDeletedCard!.id;
    if (_queue.contains(id)) {
      // To prevent unnessesary calls to the database, we remove the call to
      // delete, if the call hasn't made yet.
      _queue.remove(id);
    } else {
      _queue.add(() async {
        final repository = ref.read(sessionRepositoryProvider);
        ref.read(loggerProvider).v('Undo delete card "$id"');
        await repository.undoDeleteCard(
          sessionId: sessionId,
          cardId: id,
        );
      });
    }

    ref.read(cardsListProvider.notifier).add(_lastDeletedCard!);
    return true;
  }

  /// Clears the internal queue.
  ///
  /// This method clears the internal queue of pending deletion requests. It
  /// should be called when the session is closed.
  void clear() {
    _queue.cancel();
  }
}
