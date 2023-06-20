import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardsListProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    List<AnkiCard> generateAnkiCards(int count) {
      return List.generate(
        count,
        (index) => AnkiCard(
          id: '$index',
          question: 'Question $index',
          answer: 'Answer $index',
          createdAt: DateTime.now(),
        ),
      );
    }

    test('should initially return an empty list', () {
      final cards = container.read(cardsListProvider);

      expect(cards, isEmpty);
    });

    group('.set()', () {
      test('should set the given the list', () {
        final cards = generateAnkiCards(10);

        container.read(cardsListProvider.notifier).set(cards);

        expect(container.read(cardsListProvider), cards);
      });
    });

    group('.remove()', () {
      test('should remove the card', () {
        final cards = generateAnkiCards(10);
        container.read(cardsListProvider.notifier).set(cards);

        container.read(cardsListProvider.notifier).remove(cards.first.id);

        expect(container.read(cardsListProvider), isNot(contains(cards.first)));
      });
    });

    group('.get()', () {
      test('should return the card with id', () {
        final cards = generateAnkiCards(10);
        container.read(cardsListProvider.notifier).set(cards);

        final card =
            container.read(cardsListProvider.notifier).get(cards.first.id);

        expect(card, cards.first);
      });

      test('should return null if there is no card with this id', () {
        final cards = generateAnkiCards(10);
        container.read(cardsListProvider.notifier).set(cards);

        final card =
            container.read(cardsListProvider.notifier).get('not-exists');

        expect(card, isNull);
      });
    });
  });
}
