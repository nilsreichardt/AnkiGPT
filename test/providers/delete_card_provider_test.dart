import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

@GenerateNiceMocks([
  MockSpec<SessionRepository>(),
  MockSpec<Logger>(),
])
import 'delete_card_provider_test.mocks.dart';

void main() {
  group('DeleteCardController', () {
    late ProviderContainer container;
    late MockSessionRepository mockSessionRepository;
    late SessionId sessionId;
    late CardId cardId;
    late Uuid uuid;

    setUp(() {
      uuid = const Uuid();
      mockSessionRepository = MockSessionRepository();
      container = ProviderContainer(
        overrides: [
          loggerProvider.overrideWithValue(MockLogger()),
          sessionRepositoryProvider.overrideWithValue(mockSessionRepository),
        ],
      );

      sessionId = uuid.v4();
      cardId = uuid.v4();
    });

    AnkiCard generateCard({CardId? id}) {
      return AnkiCard(
        id: id ?? cardId,
        question: uuid.v4(),
        answer: uuid.v4(),
        createdAt: DateTime.now(),
      );
    }

    group('.delete()', () {
      test('removes card from cards list', () {
        final card = generateCard();
        container.read(cardsListProvider.notifier).set([card]);

        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: cardId,
              sessionId: sessionId,
            );

        final list = container.read(cardsListProvider);
        expect(list, isEmpty);
      });

      test('calls repository to remove the session', () {
        final card = generateCard();
        container.read(cardsListProvider.notifier).set([card]);

        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: cardId,
              sessionId: sessionId,
            );

        verify(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: cardId,
        ));
      });

      test('queues the delete call of the repository', () {
        final card1 = generateCard();
        final card2 = generateCard(id: 'cardId2');
        container.read(cardsListProvider.notifier).set([card1, card2]);

        when(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card1.id,
        )).thenAnswer((_) async {
          // Wait a bit to simulate a slow database.
          await Future.delayed(const Duration(milliseconds: 150));
        });

        // Delete card1
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card1.id,
              sessionId: sessionId,
            );

        // Delete card2
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card2.id,
              sessionId: sessionId,
            );

        verifyNever(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card2.id,
        ));
      });
    });

    group('undo()', () {
      test('should return true when reverting was successful', () {
        final card = generateCard();
        container.read(cardsListProvider.notifier).set([card]);

        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: cardId,
              sessionId: sessionId,
            );

        final result = container
            .read(deleteCardControllerProvider.notifier)
            .undo(sessionId: sessionId);

        expect(result, isTrue);
      });

      test('should add the deleted card back to the cards list', () {
        final card = generateCard();
        container.read(cardsListProvider.notifier).set([card]);

        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: cardId,
              sessionId: sessionId,
            );

        container
            .read(deleteCardControllerProvider.notifier)
            .undo(sessionId: sessionId);

        final list = container.read(cardsListProvider);
        expect(list, [card]);
      });

      test('should remove the database call if possible', () {
        final card1 = generateCard();
        final card2 = generateCard(id: 'cardId2');
        container.read(cardsListProvider.notifier).set([card1, card2]);

        when(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card1.id,
        )).thenAnswer((_) async {
          // Wait a bit to simulate a slow database.
          await Future.delayed(const Duration(milliseconds: 150));
        });

        // Delete card1
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card1.id,
              sessionId: sessionId,
            );

        // Delete card2
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card2.id,
              sessionId: sessionId,
            );

        verifyNever(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card2.id,
        ));
      });

      test('should call the repository', () {
        final card = generateCard();
        container.read(cardsListProvider.notifier).set([card]);

        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: cardId,
              sessionId: sessionId,
            );

        container
            .read(deleteCardControllerProvider.notifier)
            .undo(sessionId: sessionId);

        verify(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: cardId,
        ));
      });
    });

    group('.clear()', () {
      test('should cancels all queued calls', () {
        final card1 = generateCard();
        final card2 = generateCard(id: 'cardId2');
        container.read(cardsListProvider.notifier).set([card1, card2]);

        when(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card1.id,
        )).thenAnswer((_) async {
          // Wait a bit to simulate a slow database.
          await Future.delayed(const Duration(milliseconds: 150));
        });

        // Delete card1
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card1.id,
              sessionId: sessionId,
            );

        // Delete card2
        container.read(deleteCardControllerProvider.notifier).delete(
              cardId: card2.id,
              sessionId: sessionId,
            );

        verifyNever(mockSessionRepository.deleteCard(
          sessionId: sessionId,
          cardId: card2.id,
        ));
      });
    });
  });
}
