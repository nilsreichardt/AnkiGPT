import 'dart:math';

import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/deck_page_scroll_controller_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/generate_dummy_cards.dart';
import 'cards_list_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ScrollController>()])
void main() {
  group('CardsListController', () {
    late ProviderContainer container;
    late List<AnkiCard> cards;
    late MockScrollController mockScrollController;

    setUp(() {
      cards = generateDummyCards(CardsListController.cardsPerPage * 3);
      mockScrollController = MockScrollController();
      container = ProviderContainer(overrides: [
        deckPageScrollControllerProvider.overrideWithValue(mockScrollController)
      ]);

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

    test('should sort cards by created at date when job index is null', () {
      // Cards are created without job index
      final cards = generateDummyCards(10);

      final random = Random(42);
      final shuffeledCards = List<AnkiCard>.from(cards)..shuffle(random);
      container.read(cardsListProvider.notifier).set(shuffeledCards);

      final view = container.read(cardsListControllerProvider);
      expect(view.cards, cards);
    });

    test(
        'should sort cards by job index and then by creating date and finally by job id',
        () {
      final fixDate = DateTime(2021, 1, 1);
      final card5 = AnkiCard(
        answer: 'answer 1',
        question: 'question 1',
        createdAt: fixDate.add(const Duration(minutes: 2)),
        id: 'id5',
        job: const Job(index: 2, id: '2'),
      );
      final card3 = AnkiCard(
        answer: 'answer 3',
        question: 'question 3',
        createdAt: fixDate.add(const Duration(minutes: 2)),
        id: 'id3',
        job: const Job(index: 3, id: '3'),
      );
      final card0 = AnkiCard(
        answer: 'answer 0',
        question: 'question 0',
        createdAt: fixDate.add(const Duration(minutes: 3)),
        id: 'id0',
        job: const Job(index: 1, id: '1'),
      );
      final card10 = AnkiCard(
        answer: 'answer 0',
        question: 'question 0',
        createdAt: fixDate.add(const Duration(minutes: 1)),
        id: 'id10',
        job: const Job(index: 1, id: '1'),
      );

      final unsortedCards = [
        card5,
        card3,
        card0,
        card10,
      ];

      container.read(cardsListProvider.notifier).set(unsortedCards);
      final view = container.read(cardsListControllerProvider);

      final expectedCards = [
        card10,
        card0,
        card5,
        card3,
      ];
      expect(view.cards, expectedCards);
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

    test('scrolls to top when setting page', () {
      final cards = generateDummyCards(CardsListController.cardsPerPage * 3);
      container.read(cardsListProvider.notifier).set(cards);

      container.read(cardsListControllerProvider.notifier).setPage(2);
      verify(mockScrollController.jumpTo(250)).called(1);
    });

    test('scrolls to top when go to previous/next page', () {
      final cards = generateDummyCards(CardsListController.cardsPerPage * 3);
      container.read(cardsListProvider.notifier).set(cards);

      container.read(cardsListControllerProvider.notifier).nextPage();
      container.read(cardsListControllerProvider.notifier).previousPage();
      verify(mockScrollController.jumpTo(250)).called(2);
    });
  });
}
