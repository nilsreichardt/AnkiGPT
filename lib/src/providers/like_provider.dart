import 'package:ankigpt/src/infrastructure/like_repository.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_provider.g.dart';

@riverpod
Future<void> likeCard(
  LikeCardRef ref, {
  required SessionId sessionId,
  required CardId cardId,
  FeedbackText? text,
}) async {
  final repository = ref.read(likeRepositoryProvider);
  await repository.like(
    sessionId: sessionId,
    cardId: cardId,
    text: text,
  );
}

@riverpod
Future<void> undoLikeCard(
  UndoLikeCardRef ref, {
  required SessionId sessionId,
  required CardId cardId,
}) async {
  final repository = ref.read(likeRepositoryProvider);
  await repository.undoLike(
    sessionId: sessionId,
    cardId: cardId,
  );
}
