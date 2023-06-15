import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:queue/queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_card_provider.g.dart';

/// A provider that returns a [Queue] that contains [Future]s to delete cards.
///
/// The [Queue] is used to avoid race conditions when deleting cards.
@Riverpod(keepAlive: true)
Queue deleteQueue(DeleteQueueRef ref) => Queue();

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
