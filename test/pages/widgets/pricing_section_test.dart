import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/providers/account_view_provider.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
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

    Future<void> pumpPricingSection(
      WidgetTester tester, {
      required bool hasAccount,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: PricingSection(),
        ),
        overrides: [
          buyRepositoryProvider.overrideWithValue(mockBuyRepository),
          loggerProvider.overrideWithValue(MockLogger()),
          hasAccount2Provider.overrideWithValue(hasAccount),
          accountViewProvider.overrideWithValue(const AccountView.signedOut()),
          hasPlusProvider.overrideWithValue(false),
        ],
      );
    }

    testWidgets('opens stripe session clicking buy button', (tester) async {
      await testLink(
        tester: tester,
        find: find.text('Buy'),
        pumpWidget: (tester) => pumpPricingSection(tester, hasAccount: true),
        uri: stripeCheckoutUrl,
        webOnlyWindowName: '_self',
      );
    });

    testWidgets('logs analytics when clicking', (tester) async {
      await pumpPricingSection(tester, hasAccount: true);

      await tester.tap(find.text('Buy'));

      verify(mockBuyRepository.logClickedBuy()).called(1);
    });

    testWidgets('should open /account page when user has no account',
        (tester) async {
      await pumpPricingSection(tester, hasAccount: false);

      await tester.tap(find.text('Buy'));
      await tester.pumpAndSettle();

      expect(find.byType(AccountPage), findsOneWidget);
    });

    testGoldens('renders correctly', (tester) async {
      await pumpPricingSection(tester, hasAccount: false);

      await multiScreenGolden(tester, 'pricing_section');
    });
  });
}
