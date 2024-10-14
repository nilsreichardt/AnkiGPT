import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'stripe_checkout_provider.g.dart';

@Riverpod(keepAlive: true)
class StripeCheckout extends _$StripeCheckout {
  BuyRepository get _buyRepository => ref.read(buyRepositoryProvider);

  @override
  String? build() {
    return null;
  }

  Future<String> _generateUrl() async {
    return _buyRepository.createCheckoutSessionUrl();
  }

  Future<void> open() async {
    final logger = ref.read(loggerProvider);

    final url = await _generateUrl();
    logger.d('Opening Stripe Checkout: $url');

    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: '_self',
    );
  }
}
