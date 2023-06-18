import 'package:ankigpt/src/models/anki_card.dart';
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
}
