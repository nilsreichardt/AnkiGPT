import 'dart:math';

import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/generate_dummy_cards.dart';

void main() {
  group('CardsListController', () {
    late ProviderContainer container;
    late List<AnkiCard> cards;

    setUp(() {
      cards = generateDummyCards(CardsListController.cardsPerPage * 3);
      container = ProviderContainer();

      container.read(cardsListProvider.notifier).set(cards);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial build should correctly set up CardsListView', () {
      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.totalPages, 3);
      expect(
        view.cards,
        cards.sublist(0, CardsListController.cardsPerPage),
      );
      expect(view.canPressNext, true);
      expect(view.canPressPrevious, false);
    });

    test('sets total page to 1 when there is just one card', () {
      container.read(cardsListProvider.notifier).set([cards.first]);

      final view = container.read(cardsListControllerProvider);

      expect(view.totalPages, 1);
    });

    test('should sort cards', () {
      final cards = generateDummyCards(10);

      final random = Random(42);
      final shuffeledCards = List<AnkiCard>.from(cards)..shuffle(random);
      container.read(cardsListProvider.notifier).set(shuffeledCards);

      final view = container.read(cardsListControllerProvider);
      expect(view.cards, cards);
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

    test('sets page number even when cards list is empty', () {
      container.read(cardsListProvider.notifier).set([]);

      container.read(cardsListControllerProvider.notifier).setPage(2);
      final view = container.read(cardsListControllerProvider);
      expect(view.currentPage, 2);
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
      final cards = generateDummyCards(length);
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
      container.read(searchQueryProvider.notifier).debounce('question 10');
      container.read(searchQueryProvider.notifier).fire();

      final view = container.read(cardsListControllerProvider);

      expect(view.currentPage, 1);
      expect(view.cards, [cards[10]]);
      expect(view.canPressNext, false);
      expect(view.canPressPrevious, false);
    });

    test('should return empty list if there are no results', () {
      container.read(searchQueryProvider.notifier).debounce('no-results');
      container.read(searchQueryProvider.notifier).fire();

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
            generateDummyCards((CardsListController.cardsPerPage * 2) + 1);
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

    test(
      'should jump back to first page when all cards disappear',
      () {
        final cards =
            generateDummyCards((CardsListController.cardsPerPage * 2) + 1);
        container.read(cardsListProvider.notifier).set(cards);

        container.read(cardsListControllerProvider.notifier).setPage(3);
        final view1 = container.read(cardsListControllerProvider);
        expect(view1.currentPage, 3);

        container.read(cardsListProvider.notifier).set([]);
        final view2 = container.read(cardsListControllerProvider);
        expect(view2.currentPage, 1);
      },
    );

    test('should keep the same order after updating the list (one page)', () {
      final cards = generateDummyCards(CardsListController.cardsPerPage);
      container.read(cardsListProvider.notifier).set(cards);

      final view1 = container.read(cardsListControllerProvider);

      final updatedCards = List<AnkiCard>.from(cards);
      final fixRandom = Random(42);
      updatedCards.shuffle(fixRandom);
      container.read(cardsListProvider.notifier).set(updatedCards);

      final view2 = container.read(cardsListControllerProvider);
      expect(view2.cards, view1.cards);
    });

    // Regression test for: https://github.com/nilsreichardt/ankigpt/issues/65
    test('should keep the same order after updating the list (multiple pages)',
        () {
      final cards = generateDummyCards(CardsListController.cardsPerPage * 3);
      container.read(cardsListProvider.notifier).set(cards);

      final view1 = container.read(cardsListControllerProvider);

      final updatedCards = List<AnkiCard>.from(cards);
      final fixRandom = Random(42);
      updatedCards.shuffle(fixRandom);
      container.read(cardsListProvider.notifier).set(updatedCards);

      final view2 = container.read(cardsListControllerProvider);
      expect(view2.cards, view1.cards);
    });
  });
}
