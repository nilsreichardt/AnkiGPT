import 'package:ankigpt/src/models/anki_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cards_list_view.freezed.dart';

@freezed
class CardsListView with _$CardsListView {
  const CardsListView._();

  const factory CardsListView({
    required List<AnkiCard> cards,
    required int currentPage,
    required int totalPages,
    required bool canPressNext,
    required bool canPressPrevious,
  }) = _CardsListView;

  factory CardsListView.empty() {
    return const CardsListView(
      cards: [],
      currentPage: 1,
      totalPages: 1,
      canPressNext: false,
      canPressPrevious: false,
    );
  }
}
