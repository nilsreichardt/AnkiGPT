import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/home_page/faq_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(FaqSection, () {
    Future<void> pumpFaqSection(
      WidgetTester tester, {
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        body: const SingleChildScrollView(
          child: FaqSection(),
        ),
      );
    }

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpFaqSection(tester, variant: variant);

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'faq_section_without_answer',
      );
    });

    testAdaptiveWidgets('renders answers as expeceted',
        (tester, variant) async {
      await pumpFaqSection(tester, variant: variant);

      await tester.tap(find.text('Is the source code of AnkiGPT public?'));
      await tester.pumpAndSettle();

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'faq_section_with_answer',
      );
    });
  });
}
