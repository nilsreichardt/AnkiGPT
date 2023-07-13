import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/home_page/about_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(AboutSection, () {
    Future<void> pumpAboutSection(
      WidgetTester tester, {
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        body: const SingleChildScrollView(
          child: AboutSection(),
        ),
      );
    }

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpAboutSection(tester, variant: variant);

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'about_section',
      );
    });
  });
}
