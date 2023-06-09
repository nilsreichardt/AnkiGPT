import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_provider.g.dart';

const routeFunctionsUrl = 'https://route-haaaagicoa-ew.a.run.app';

@riverpod
Future<void> buy(BuyRef ref) async {
  final cloudFunctions = ref.read(cloudFunctionsProvider);
  await cloudFunctions.httpsCallableFromUrl(routeFunctionsUrl).call({
    'destination': 'analyticsBuy',
  });
}
