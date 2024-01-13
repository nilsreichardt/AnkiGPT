import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/providers/edit_question_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<SessionRepository>(),
  MockSpec<Logger>(),
])
import 'delete_card_provider_test.mocks.dart';

void main() {
  group('EditQuestionProvider', () {
    late ProviderContainer container;
    late MockSessionRepository mockSessionRepository;

    setUp(() {
      mockSessionRepository = MockSessionRepository();
      container = ProviderContainer(
        overrides: [
          loggerProvider.overrideWithValue(MockLogger()),
          sessionRepositoryProvider.overrideWithValue(mockSessionRepository),
        ],
      );
    });

    test('should call the repository', () async {
      container.read(editQuestionProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editQuestionProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            question: 'question',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verify(mockSessionRepository.editQuestion(
        sessionId: 'sessionId',
        cardId: 'cardId',
        question: 'question',
      )).called(1);
    });

    test('should queue the edit', () async {
      when(mockSessionRepository.editQuestion(
        sessionId: 'sessionId',
        cardId: 'cardId',
        question: 'question',
      )).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
      });

      container.read(editQuestionProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editQuestionProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            question: 'question',
          );
      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      container.read(editQuestionProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId2',
            question: 'second-question',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verifyNever(mockSessionRepository.editQuestion(
        sessionId: 'sessionId',
        cardId: 'cardId2',
        question: 'second-question',
      ));
    });

    test('.clear() should reset the provider', () async {
      container.read(editQuestionProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editQuestionProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            question: 'question',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verifyNever(mockSessionRepository.editQuestion(
        sessionId: 'sessionId',
        cardId: 'cardId',
        question: 'question',
      ));
    });
  });
}
