import 'package:ankigpt/src/providers/buy_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'stripe_checkout_provider.g.dart';

@Riverpod(keepAlive: true)
class StripeCheckout extends _$StripeCheckout {
  @override
  String? build() {
    return null;
  }

  Future<String> generateUrl() async {
    final url = await ref.read(buyProvider.future);
    state = url;
    return url;
  }

  void reset() {
    state = null;
  }

  Future<void> open() async {
    final logger = ref.read(loggerProvider);

    final url = state ?? await generateUrl();
    logger.d('Opening Stripe Checkout: $url');

    final uri = Uri.parse(url);

    reset();
    await launchUrl(uri, webOnlyWindowName: '_self');
  }
}
