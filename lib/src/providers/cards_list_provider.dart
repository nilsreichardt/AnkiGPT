import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cards_list_provider.g.dart';

@Riverpod(keepAlive: true)
class CardsList extends _$CardsList {
  @override
  List<AnkiCard> build() {
    return [];
  }

  void set(List<AnkiCard> cards) {
    state = cards;
  }

  AnkiCard? remove(CardId cardId) {
    final card = get(cardId);
    if (card == null) {
      // Could not find
      return null;
    }

    state = state.where((card) => card.id != cardId).toList();
    return card;
  }

  AnkiCard? get(CardId cardId) {
    return state.firstWhereOrNull((card) => card.id == cardId);
  }

  void add(AnkiCard card) {
    state = [...state, card];
  }
}
