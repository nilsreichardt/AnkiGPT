import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_button_analytics.g.dart';

@riverpod
Future<void> clickedBuy(ClickedBuyRef ref) async {
  final repository = ref.read(buyRepositoryProvider);
  await repository.logClickedBuy();
}
