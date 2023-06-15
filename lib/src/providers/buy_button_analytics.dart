import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_button_analytics.g.dart';

@riverpod
Future<void> clickedBuy(ClickedBuyRef ref) async {
  final cloudFunctions = ref.read(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  await cloudFunctions.httpsCallableFromUrl(routeUrl).call({
    'destination': 'analyticsBuy',
  });
}
