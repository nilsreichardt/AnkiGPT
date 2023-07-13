import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/providers/version_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../utils/pump_ankigpt_app.dart';
import '../../utils/test_link_util.dart';

void main() {
  group(Footer, () {
    Widget getBody() {
      return const Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Footer(),
            ],
          ),
        ),
      );
    }

    Future<void> pumpFooter(
      WidgetTester tester, {
      String version = 'Apr 1 2023',
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        overrides: [
          versionProvider.overrideWith((ref) => version),
        ],
        body: getBody(),
      );
    }

    group('Product', () {
      testWidgets('opens GitHub, when clicks on "Source Code"', (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('Source Code'),
          uri: 'https://github.com/nilsreichardt/ankigpt',
        );
      });

      testWidgets('opens support link, when clicks on "Feedback"',
          (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('Feedback'),
          uri: 'https://ankigpt.help/support',
        );
      });
    });

    group('Contact', () {
      testWidgets('opens support link, when clicks on "WhatsApp"',
          (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('WhatsApp'),
          uri: 'https://ankigpt.help/support',
        );
      });

      testWidgets('opens email, when clicks on "Email"', (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('Email'),
          uri: 'mailto:support@ankigpt.help',
        );
      });
    });

    group('Legal', () {
      testWidgets('opens terms of service, when clicks on "Terms of Service"',
          (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('Terms of Service'),
          uri: 'https://ankigpt.help/terms-of-service',
        );
      });

      testWidgets('opens privacy policy, when clicks on "Privacy Policy"',
          (tester) async {
        await testLink(
          tester: tester,
          pumpWidget: pumpFooter,
          find: find.text('Privacy Policy'),
          uri: 'https://ankigpt.help/privacy-policy',
        );
      });

      testWidgets('opens imprint, when clicks on "Imprint"', (tester) async {
        final router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Scaffold(body: getBody()),
              routes: [
                GoRoute(
                  path: 'imprint',
                  builder: (context, state) => const ImprintPage(),
                ),
              ],
            ),
          ],
        );
        await pumpAnkiGptAppWithRouter(
          tester: tester,
          router: router,
        );

        await tester.tap(find.text('Imprint'));
        await tester.pumpAndSettle();

        expect(find.byType(ImprintPage), findsOneWidget);
      });
    });

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpFooter(tester, variant: variant);

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'footer',
      );
    });
  });
}
