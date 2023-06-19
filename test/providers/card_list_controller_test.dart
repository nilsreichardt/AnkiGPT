import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/search_query_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardsListController', () {
    late ProviderContainer container;
    late List<AnkiCard> cards;

    setUp(() {
      cards = _generateAnkiCards(CardsListController.cardsPerPage * 3);
      container = ProviderContainer();

      container.read(cardsListProvider.notifier).set(cards);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial build should correctly set up CardsListView', () {
      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(
        view.cards,
        cards.sublist(0, CardsListController.cardsPerPage),
      );
      expect(view.canPressNext, true);
      expect(view.canPressPrevious, false);
    });

    test('should correctly switch to the next page', () {
      container.read(cardsListControllerProvider.notifier).nextPage();

      final view = container.read(cardsListControllerProvider);
      expect(view.currentPage, 2);
      expect(
          view.cards,
          cards.sublist(
            CardsListController.cardsPerPage,
            CardsListController.cardsPerPage * 2,
          ));
      expect(view.canPressNext, true);
      expect(view.canPressPrevious, true);
    });

    test('should correctly switch to the previous page', () {
      // Move to the second page first to test going back.
      container.read(cardsListControllerProvider.notifier).nextPage();

      container.read(cardsListControllerProvider.notifier).previousPage();

      final view = container.read(cardsListControllerProvider);
      expect(view.currentPage, 1);
      expect(view.cards, cards.sublist(0, CardsListController.cardsPerPage));
      expect(view.canPressNext, true);
      expect(view.canPressPrevious, false);
    });

    test('should handle if cards list does not fit perfectly', () {
      const length = CardsListController.cardsPerPage - 1;
      final cards = _generateAnkiCards(length);
      container.read(cardsListProvider.notifier).set(cards);

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.cards, cards.sublist(0, length));
      expect(view.canPressNext, false);
      expect(view.canPressPrevious, false);
    });

    test('should handle if cards list is empty', () {
      container.read(cardsListProvider.notifier).set([]);

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.cards, []);
      expect(view.canPressNext, false);
      expect(view.canPressPrevious, false);
    });

    test('should filter based on search query ', () {
      container.read(searchQueryProvider.notifier).set('question 10');

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.cards, [cards[10]]);
      expect(view.canPressNext, false);
      expect(view.canPressPrevious, false);
    });

    test('should return empty list if there are no results', () {
      container.read(searchQueryProvider.notifier).set('no-results');

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.cards, []);
      expect(view.canPressNext, false);
      expect(view.canPressPrevious, false);
    });

    test('should navigate to page when user set page', () {
      container.read(cardsListControllerProvider.notifier).setPage(2);

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 2);
      expect(
          view.cards,
          cards.sublist(
            CardsListController.cardsPerPage,
            CardsListController.cardsPerPage * 2,
          ));
      expect(view.canPressNext, true);
      expect(view.canPressPrevious, true);
    });

    test(
      'should go to previous page when current page disappears',
      () {
        final cards =
            _generateAnkiCards((CardsListController.cardsPerPage * 2) + 1);
        container.read(cardsListProvider.notifier).set(cards);

        container.read(cardsListControllerProvider.notifier).setPage(3);
        final view1 = container.read(cardsListControllerProvider);
        expect(view1.currentPage, 3);

        container
            .read(cardsListProvider.notifier)
            .set(cards.sublist(0, CardsListController.cardsPerPage * 2));
        final view2 = container.read(cardsListControllerProvider);
        expect(view2.currentPage, 2);
      },
    );
  });
}

List<AnkiCard> _generateAnkiCards(int count) {
  return List<AnkiCard>.generate(
    count,
    (index) => AnkiCard(
      answer: 'answer $index',
      question: 'question $index',
      createdAt: DateTime.now(),
      id: '$index',
    ),
  );
}
