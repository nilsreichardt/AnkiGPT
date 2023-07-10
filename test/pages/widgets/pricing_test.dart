import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/pages/home_page/pricing_section.dart';
import 'package:ankigpt/src/providers/buy_repostiroy_provider.dart.dart';
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

    Future<void> pumpPricingSection(WidgetTester tester) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: PricingSection(),
        ),
        overrides: [
          buyRepositoryProvider.overrideWithValue(mockBuyRepository),
          loggerProvider.overrideWithValue(MockLogger()),
        ],
      );
    }

    testWidgets('opens stripe session clicking buy button', (tester) async {
      await testLink(
        tester: tester,
        find: find.text('Buy'),
        pumpWidget: pumpPricingSection,
        uri: stripeCheckoutUrl,
        webOnlyWindowName: '_self',
      );
    });

    testGoldens('renders correctly', (tester) async {
      await pumpPricingSection(tester);

      await multiScreenGolden(tester, 'pricing_section');
    });
  });
}
