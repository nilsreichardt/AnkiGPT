import 'package:ankigpt/src/pages/home_page/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(HomePageDrawer, () {
    Future<void> pumpHomePageDrawer(WidgetTester tester) async {
      await pumpAnkiGptApp(
        tester: tester,
        drawer: const HomePageDrawer(),
        body: Builder(builder: (context) {
          return ElevatedButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            child: const Text('Open Drawer'),
          );
        }),
      );
    }

    testGoldens('renders as expected', (tester) async {
      await pumpHomePageDrawer(tester);

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      await multiScreenGolden(tester, 'home_page_drawer');
    });
  });
}
