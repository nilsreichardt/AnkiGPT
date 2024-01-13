import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clear_session_state_provider.g.dart';

@riverpod
class ClearSessionState extends _$ClearSessionState {
  @override
  void build() {}

  void clear() {
    ref.read(cardsListProvider.notifier).clear();
    ref.read(searchQueryProvider.notifier).clear();
  }
}
