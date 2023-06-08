import 'package:ankigpt/src/infrastructure/dislike_repository.dart';
import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dislike_provider.g.dart';

@riverpod
Future<void> dislikeCard(
  DislikeCardRef ref, {
  required SessionId sessionId,
  required CardId cardId,
  Map<CardFeedbackType, bool>? checkboxes,
  FeedbackText? text,
}) async {
  final repository = ref.read(dislikeRepositoryProvider);
  await repository.dislike(
    sessionId: sessionId,
    cardId: cardId,
    types: checkboxes?.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList(),
    text: text,
  );
}

@riverpod
Future<void> undoDislikeCard(
  UndoDislikeCardRef ref, {
  required SessionId sessionId,
  required CardId cardId,
}) async {
  final repository = ref.read(dislikeRepositoryProvider);
  await repository.undoDislike(
    sessionId: sessionId,
    cardId: cardId,
  );
}
