import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_stripe_portal_provider.g.dart';

@riverpod
Future<String> openStripePortal(OpenStripePortalRef ref) async {
  try {
    final cloudFunctions = ref.read(cloudFunctionsProvider);

    final response = await cloudFunctions
        .httpsCallable('ext-firestore-stripe-payments-createPortalLink')
        .call<Map<String, dynamic>>({
      'returnUrl': 'https://ankigpt.wtf/account',
    });

    return response.data['url'];
  } catch (e, s) {
    ref.read(loggerProvider).e('Could not generate portal link', e, s);
    rethrow;
  }
}
