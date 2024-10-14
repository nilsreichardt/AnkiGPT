import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:ankigpt/src/providers/clock_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:clock/clock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../mocks/mock_url_launcher_platform.dart';
import 'stripe_checkout_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<BuyRepository>(),
  MockSpec<Logger>(),
  MockSpec<Clock>(),
])
void main() {
  group(StripeCheckout, () {
    late ProviderContainer container;
    late MockUrlLauncher mockUrlLauncher;
    late MockBuyRepository mockBuyRepository;
    late MockClock mockClock;

    late String firstCheckoutUrl;
    late String secondCheckoutUrl;

    final baseDateTime = DateTime(2023, 1, 1);

    setUp(() {
      mockUrlLauncher = MockUrlLauncher();
      UrlLauncherPlatform.instance = mockUrlLauncher;
      mockBuyRepository = MockBuyRepository();
      mockClock = MockClock();

      firstCheckoutUrl = 'https://example.com/1';
      secondCheckoutUrl = 'https://example.com/2';

      container = ProviderContainer(
        overrides: [
          loggerProvider.overrideWithValue(MockLogger()),
          buyRepositoryProvider.overrideWithValue(mockBuyRepository),
          clockProvider.overrideWithValue(mockClock),
        ],
      );

      when(mockClock.now()).thenReturn(baseDateTime);
      when(mockBuyRepository.createCheckoutSessionUrl())
          .thenAnswer((_) async => firstCheckoutUrl);
    });

    tearDown(() {
      container.dispose();
    });

    group('open()', () {
      test('opens Stripe checkout URL', () async {
        final checkout = container.read(stripeCheckoutProvider.notifier);
        mockUrlLauncher.setLaunchExpectations(
          url: firstCheckoutUrl,
          webOnlyWindowName: '_self',
        );

        await checkout.open();

        expect(mockUrlLauncher.launchCalled, isTrue);
      });

      test('does not reuse URL after use', () async {
        final checkout = container.read(stripeCheckoutProvider.notifier);

        mockUrlLauncher.setLaunchExpectations(
          url: firstCheckoutUrl,
          webOnlyWindowName: '_self',
        );
        await checkout.open();

        when(mockBuyRepository.createCheckoutSessionUrl())
            .thenAnswer((_) async => secondCheckoutUrl);
        mockUrlLauncher.setLaunchExpectations(
          // The URL should be the same as the first one even when the buy
          // repository returns a different one.
          url: secondCheckoutUrl,
          webOnlyWindowName: '_self',
        );
        await checkout.open();

        expect(mockUrlLauncher.launchCalled, isTrue);
      });
    });
  });
}
