import 'dart:math';

import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/cards_list_view.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cards_list_controller.g.dart';

@Riverpod(keepAlive: true)
class CardsListController extends _$CardsListController {
  static const int cardsPerPage = 20;

  // We need keep a copy of the current page because we can't access state.currentPage during the build method.
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

  CardsListView _buildView(List<AnkiCard> cards, {required currentPage}) {
    if (cards.isEmpty) {
      return CardsListView.empty();
    }

    final totalPages = (cards.length / cardsPerPage).ceil();

    int startIndex = _calcStartIndex(currentPage);
    while (startIndex >= cards.length) {
      currentPage = currentPage! - 1;
      startIndex = _calcStartIndex(currentPage);
    }

    final endIndex = min(startIndex + cardsPerPage, cards.length);
    final sortedCards = cards.toList()..sortByCreatedAt();
    final visibleCards = sortedCards.sublist(startIndex, endIndex);

    _currentPage = currentPage;
    return CardsListView(
      cards: visibleCards,
      currentPage: currentPage!,
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
    }
  }

  void previousPage() {
    if (state.canPressPrevious) {
      final cards = ref.read(cardsListProvider);
      state = _buildView(cards, currentPage: state.currentPage - 1);
    }
  }

  void setPage(int page) {
    final cards = ref.read(cardsListProvider);
    state = _buildView(cards, currentPage: page);
  }
}

extension on List<AnkiCard> {
  void sortByCreatedAt() {
    // Sort first by createdAt than by id. This way we can ensure that the order is always the same.
    sort((a, b) {
      final createdAtComparison = a.createdAt.compareTo(b.createdAt);
      if (createdAtComparison != 0) {
        return createdAtComparison;
      }
      return a.id.compareTo(b.id);
    });
  }
}
