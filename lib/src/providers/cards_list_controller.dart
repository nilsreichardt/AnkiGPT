import 'dart:math';

import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/cards_list_view.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/deck_page_scroll_controller_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cards_list_controller.g.dart';

@riverpod
class CardsListController extends _$CardsListController {
  static const int cardsPerPage = 20;

  // We need keep a copy of the current page because we can't access
  // state.currentPage during the build method.
  //
  // See https://github.com/rrousselGit/riverpod/issues/2663
  int _currentPage = 1;

  @override
  CardsListView build() {
    List<AnkiCard> cards = ref.watch(cardsListProvider);

    final query = ref.watch(searchQueryProvider);
    cards = _maybeFilterCards(cards, query);

    return _buildView(cards, currentPage: _currentPage);
  }

  List<AnkiCard> _maybeFilterCards(List<AnkiCard> cards, String query) {
    if (query.isEmpty) {
      return cards;
    }

    return cards.where((card) {
      final q = card.question.toLowerCase();
      final a = card.answer.toLowerCase();
      final queryLowerCase = query.toLowerCase();
      return q.contains(queryLowerCase) || a.contains(queryLowerCase);
    }).toList();
  }

  CardsListView _buildView(List<AnkiCard> cards, {required int currentPage}) {
    _currentPage = currentPage;
    if (cards.isEmpty) {
      return CardsListView.empty(currentPage: currentPage);
    }

    final totalPages = (cards.length / cardsPerPage).ceil();

    int startIndex = _calcStartIndex(currentPage);
    while (startIndex >= cards.length) {
      currentPage = currentPage - 1;
      startIndex = _calcStartIndex(currentPage);
    }

    final endIndex = min(startIndex + cardsPerPage, cards.length);
    final sortedCards = cards.toList()..sortByJobIndex();
    final visibleCards = sortedCards.sublist(startIndex, endIndex);

    return CardsListView(
      cards: visibleCards,
      currentPage: currentPage,
      totalPages: totalPages,
      canPressNext: currentPage < totalPages,
      canPressPrevious: currentPage > 1,
    );
  }

  int _calcStartIndex(int currentPage) => (currentPage - 1) * cardsPerPage;

  void nextPage() {
    if (state.canPressNext) {
      final cards = ref.read(cardsListProvider);
      state = _buildView(cards, currentPage: state.currentPage + 1);
      _scrolToTop();
    }
  }

  void previousPage() {
    if (state.canPressPrevious) {
      final cards = ref.read(cardsListProvider);
      state = _buildView(cards, currentPage: state.currentPage - 1);
      _scrolToTop();
    }
  }

  void setPage(int page) {
    final cards = ref.read(cardsListProvider);
    state = _buildView(cards, currentPage: page);
    _scrolToTop();
  }

  void _scrolToTop() {
    final scrollController = ref.read(deckPageScrollControllerProvider);
    // We do not scroll to the actual top because there is the input field. To
    // provide a better user experience we scroll to the top of the cards list
    // instead which is 250 pixels below the actual top.
    scrollController.jumpTo(250);
  }
}

extension on List<AnkiCard> {
  /// Sorts the cards by the job index (can be null), than by the creation date and finally
  /// by the id.
  void sortByJobIndex() {
    sort((a, b) {
      final jobIndexComparison = a.job?.index.compareTo(b.job?.index ?? 0) ?? 0;
      if (jobIndexComparison != 0) {
        return jobIndexComparison;
      }

      final createdAtComparison = a.createdAt.compareTo(b.createdAt);
      if (createdAtComparison != 0) {
        return createdAtComparison;
      }

      return a.id.compareTo(b.id);
    });
  }
}
