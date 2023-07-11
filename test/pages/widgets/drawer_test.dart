import 'package:ankigpt/src/pages/home_page/drawer.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(HomePageDrawer, () {
    Future<void> pumpHomePageDrawer(
      WidgetTester tester, {
      bool isSignedIn = false,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
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
      expect(find.text('Decks'), findsNothing);
    });

    testWidgets('shows decks tile when user is signed', (tester) async {
      await pumpHomePageDrawer(tester, isSignedIn: true);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      expect(find.text('Decks'), findsOneWidget);
      expect(find.text('Demo'), findsNothing);
    });

    testGoldens('renders as expected', (tester) async {
      await pumpHomePageDrawer(tester);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      await multiScreenGolden(tester, 'home_page_drawer');
    });
  });
}
