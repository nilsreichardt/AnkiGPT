import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/providers/edit_answer_provider.dart';
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
  group('EditAnswerProvider', () {
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
      container.read(editAnswerProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editAnswerProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            answer: 'answer',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verify(mockSessionRepository.editAnswer(
        sessionId: 'sessionId',
        cardId: 'cardId',
        answer: 'answer',
      )).called(1);
    });

    test('should queue the edit', () async {
      when(mockSessionRepository.editAnswer(
        sessionId: 'sessionId',
        cardId: 'cardId',
        answer: 'answer',
      )).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
      });

      container.read(editAnswerProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editAnswerProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            answer: 'answer',
          );
      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      container.read(editAnswerProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId2',
            answer: 'second-Answer',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verifyNever(mockSessionRepository.editAnswer(
        sessionId: 'sessionId',
        cardId: 'cardId2',
        answer: 'second-Answer',
      ));
    });

    test('.clear() should reset the provider', () async {
      container.read(editAnswerProvider.notifier).setDebounceDuration(
            const Duration(milliseconds: 1),
          );

      container.read(editAnswerProvider.notifier).debounce(
            sessionId: 'sessionId',
            cardId: 'cardId',
            answer: 'answer',
          );

      // Wait for the debounce duration
      await Future.delayed(const Duration(milliseconds: 1));

      verifyNever(mockSessionRepository.editAnswer(
        sessionId: 'sessionId',
        cardId: 'cardId',
        answer: 'answer',
      ));
    });
  });
}
