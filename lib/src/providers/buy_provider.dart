import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/developer_mode_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'buy_provider.g.dart';

@riverpod
Future<void> buy(BuyRef ref) async {
  final cloudFunctions = ref.read(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  final logger = ref.read(loggerProvider);
  final isDeveloperMode = ref.read(hasDeveloperModeProvider);

  final respsonse = await cloudFunctions
      .httpsCallableFromUrl(routeUrl)
      .call<Map<String, dynamic>>({
    'destination': 'createCheckoutSession',
    'payload': {
      'priceId': isDeveloperMode ? 'price_1NJ0vbBWpb6oLyvXoE4QUewc' : null,
    }
  });

  final url = respsonse.data['url'] as String?;
  if (url == null) {
    logger.e('Checkout session URL is null');
    return;
  }

  launchUrl(Uri.parse(url));
}

class UnauthenticatedException implements Exception {
  const UnauthenticatedException();
}
