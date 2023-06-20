import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:queue/queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_card_provider.g.dart';

/// A provider that returns a [Queue] that contains [Future]s to delete cards.
///
/// The [Queue] is used to avoid race conditions when deleting cards.
@Riverpod(keepAlive: true)
Queue deleteQueue(DeleteQueueRef ref) => Queue();

@Riverpod(keepAlive: true)
class DeleteCardController extends _$DeleteCardController {
  final _queue = Queue();
  AnkiCard? _lastDeletedCard;

  @override
  void build() {
    return;
  }

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
    );
  }

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
}

@riverpod
void deleteCard(
  DeleteCardRef ref, {
  required CardId cardId,
  required SessionId sessionId,
}) {
  ref.read(deleteQueueProvider).add(() async => await ref
      .read(sessionRepositoryProvider)
      .deleteCard(sessionId: sessionId, cardId: cardId));
}

@riverpod
void undoDeleteCard(
  UndoDeleteCardRef ref, {
  required CardId cardId,
  required SessionId sessionId,
}) {
  final queue = ref.read(deleteQueueProvider);
  if (queue.contains(cardId)) {
    queue.remove(cardId);
  } else {
    queue.add(() async => await ref
        .read(sessionRepositoryProvider)
        .undoDeleteCard(sessionId: sessionId, cardId: cardId));
  }
}
