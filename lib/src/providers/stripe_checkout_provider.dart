import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:ankigpt/src/providers/clock_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'stripe_checkout_provider.g.dart';

@Riverpod(keepAlive: true)
class StripeCheckout extends _$StripeCheckout {
  /// The duration after which the Stripe Checkout URL will expire.
  Duration _expireDuration = const Duration(hours: 23);
  DateTime? _lastGeneratedAt;

  BuyRepository get _buyRepository => ref.read(buyRepositoryProvider);
  bool get _isExpired {
    if (_lastGeneratedAt == null) {
      return true;
    }

    final clock = ref.read(clockProvider);
    return clock.now().difference(_lastGeneratedAt!) > _expireDuration;
  }

  @override
  String? build() {
    return null;
  }

  Future<String> generateUrl() async {
    final currentUrl = state;
    if (currentUrl != null && !_isExpired) {
      return state!;
    }

    final url = await _buyRepository.createCheckoutSessionUrl();

    _setLastGeneratedAtToNow();
    state = url;

    return url;
  }

  void reset() {
    state = null;
    _lastGeneratedAt = null;
  }

  Future<void> open() async {
    final logger = ref.read(loggerProvider);

    final url = await _getUrl();
    logger.d('Opening Stripe Checkout: $url');

    reset();
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
  }

  @visibleForTesting
  void setExpireDuration(Duration duration) {
    _expireDuration = duration;
  }

  Future<String> _getUrl() async {
    if (_lastGeneratedAt == null) {
      return generateUrl();
    }

    if (_isExpired) {
      return generateUrl();
    }

    final currentUrl = state;
    if (currentUrl == null) {
      return generateUrl();
    }

    return currentUrl;
  }

  void _setLastGeneratedAtToNow() {
    final clock = ref.read(clockProvider);
    _lastGeneratedAt = clock.now();
  }
}
