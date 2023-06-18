import 'dart:math';

import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/search_query_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cards_list_controller.g.dart';

@Riverpod(keepAlive: true)
class CardsListController extends _$CardsListController {
  static const int cardsPerPage = 20;
  bool _hasBeenInitialized = false;

  @override
  CardsListView build() {
    List<AnkiCard> cards = ref.watch(cardsListProvider);

    final query = ref.watch(searchQueryProvider);
    cards = _maybeFilterCards(cards, query);

    final view = _buildView(cards);

    if (!_hasBeenInitialized) {
      _hasBeenInitialized = true;
    }

    return view;
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

  CardsListView _buildView(List<AnkiCard> cards, {int? currentPage}) {
    currentPage ??= _hasBeenInitialized ? state.currentPage : 1;

    final totalPages = cards.length ~/ cardsPerPage;

    int startIndex = _calcStartIndex(currentPage);
    while (startIndex > cards.length) {
      currentPage = currentPage! - 1;
      startIndex = _calcStartIndex(currentPage);
    }

    final endIndex = min(startIndex + cardsPerPage, cards.length);
    final visibleCards =
        cards.isEmpty ? cards : cards.sublist(startIndex, endIndex);

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
