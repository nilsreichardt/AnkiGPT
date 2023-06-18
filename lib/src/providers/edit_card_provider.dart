import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_card_provider.g.dart';

@riverpod
Future<void> editAnswer(
  EditAnswerRef ref, {
  required String answer,
  required CardId cardId,
  required SessionId sessionId,
}) async {
  await ref.read(sessionRepositoryProvider).editAnswer(
        sessionId: sessionId,
        cardId: cardId,
        answer: answer,
      );
}

@riverpod
Future<void> editQuestion(
  EditQuestionRef ref, {
  required String question,
  required CardId cardId,
  required SessionId sessionId,
}) async {
  await ref.read(sessionRepositoryProvider).editQuestion(
        sessionId: sessionId,
        cardId: cardId,
        question: question,
      );
}
