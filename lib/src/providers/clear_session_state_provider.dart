import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/edit_answer_provider.dart';
import 'package:ankigpt/src/providers/edit_question_provider.dart';
import 'package:ankigpt/src/providers/scroll_controller_provider.dart';
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
    ref.read(editAnswerProvider.notifier).clear();
    ref.read(editQuestionProvider.notifier).clear();
    ref.read(deleteCardControllerProvider.notifier).clear();
    ref.read(scrollControllerProvider).jumpTo(0);
  }
}
