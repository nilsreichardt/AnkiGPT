import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/providers/account_view_provider.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../providers/stripe_checkout_provider_test.mocks.dart';
import '../../utils/pump_ankigpt_app.dart';
import '../../utils/test_link_util.dart';

@GenerateNiceMocks([
  MockSpec<BuyRepository>(),
  MockSpec<Logger>(),
])
void main() {
  group(PricingSection, () {
    String stripeCheckoutUrl = 'https://example.com';
    late MockBuyRepository mockBuyRepository;

    setUp(() {
      mockBuyRepository = MockBuyRepository();
      when(mockBuyRepository.createCheckoutSessionUrl()).thenAnswer(
        (_) async => stripeCheckoutUrl,
      );
    });

    Widget getBody() {
      return const SingleChildScrollView(
        child: PricingSection(),
      );
    }

    Future<void> pumpPricingSection(
      WidgetTester tester, {
      required bool hasAccount,
      WindowConfigData? variant,
      GoRouter? router,
    }) async {
      final overrides = [
        buyRepositoryProvider.overrideWithValue(mockBuyRepository),
        loggerProvider.overrideWithValue(MockLogger()),
        hasAccount2Provider.overrideWithValue(hasAccount),
        accountViewProvider.overrideWithValue(const AccountView.signedOut()),
        hasPlusProvider.overrideWithValue(false),
      ];
      if (router == null) {
        await pumpAnkiGptApp(
          tester: tester,
          variant: variant,
          body: getBody(),
          overrides: overrides,
        );
      } else {
        await pumpAnkiGptAppWithRouter(
          tester: tester,
          router: router,
          overrides: overrides,
        );
      }
    }

    testWidgets('opens stripe session clicking buy button', (tester) async {
      await testLink(
        tester: tester,
        find: find.text('Buy'),
        pumpWidget: (tester) async {
          await pumpPricingSection(tester, hasAccount: true);
          await tester.ensureVisible(find.text('Buy'));
        },
        uri: stripeCheckoutUrl,
        webOnlyWindowName: '_self',
      );
    });

    testWidgets('logs analytics when clicking', (tester) async {
      await pumpPricingSection(tester, hasAccount: true);

      await tester.ensureVisible(find.text('Buy'));
      await tester.tap(find.text('Buy'));

      verify(mockBuyRepository.logClickedBuy()).called(1);
    });

    testWidgets('should open /account page when user has no account',
        (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(body: getBody()),
            routes: [
              GoRoute(
                path: 'account',
                builder: (context, state) => const AccountPage(),
              ),
            ],
          ),
        ],
      );
      await pumpPricingSection(tester, hasAccount: false, router: router);

      await tester.ensureVisible(find.text('Buy'));
      await tester.tap(find.text('Buy'));
      await tester.pumpAndSettle();

      expect(find.byType(AccountPage), findsOneWidget);
    });

    testAdaptiveWidgets(
      'renders correctly',
      (tester, variant) async {
        await pumpPricingSection(
          tester,
          hasAccount: false,
          variant: variant,
        );

        await tester.expectGolden<ProviderScope>(
          variant,
          suffix: 'pricing_section',
        );
      },
      // Currently, there is a overflow issue in the tests.
      skip: true,
    );
  });
}
