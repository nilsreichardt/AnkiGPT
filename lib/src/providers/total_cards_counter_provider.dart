import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'total_cards_counter_provider.g.dart';

@Riverpod(keepAlive: true)
int totalCardsCount(TotalCardsCountRef ref) {
  final cards = ref.watch(cardsListProvider);
  return cards.length;
}
