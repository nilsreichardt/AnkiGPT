import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/home_page/drawer.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(HomePageDrawer, () {
    Future<void> pumpHomePageDrawer(
      WidgetTester tester, {
      bool isSignedIn = false,
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        drawer: const HomePageDrawer(),
        body: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: const Text('Open Drawer'),
          );
        }),
        overrides: [
          isSignedInProvider.overrideWithValue(isSignedIn),
        ],
      );
    }

    testWidgets('shows demo tile when user is not signed', (tester) async {
      await pumpHomePageDrawer(tester);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('Demo'), findsOneWidget);
      expect(find.text('My Decks'), findsNothing);
    });

    testWidgets('shows decks tile when user is signed', (tester) async {
      await pumpHomePageDrawer(tester, isSignedIn: true);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('My Decks'), findsOneWidget);
      expect(find.text('Demo'), findsNothing);
    });

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpHomePageDrawer(tester, variant: variant);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'drawer',
      );
    });
  });
}
