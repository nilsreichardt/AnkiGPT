import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/developer_mode_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_provider.g.dart';

const _testPriceId = 'price_1NJ0vbBWpb6oLyvXoE4QUewc';

@riverpod
Future<String> buy(BuyRef ref) async {
  final cloudFunctions = ref.read(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  final isDeveloperMode = ref.read(hasDeveloperModeProvider);
  final logger = ref.read(loggerProvider);

  if (isDeveloperMode) {
    logger.d('Generating Stripe Checkout URL for developer mode');
  }

  final respsonse = await cloudFunctions
      .httpsCallableFromUrl(routeUrl)
      .call<Map<String, dynamic>>({
    'destination': 'createCheckoutSession',
    'payload': {
      'priceId': isDeveloperMode ? _testPriceId : null,
    }
  });

  return respsonse.data['url'] as String;
}

class UnauthenticatedException implements Exception {
  const UnauthenticatedException();
}
