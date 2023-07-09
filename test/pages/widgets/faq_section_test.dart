import 'package:ankigpt/src/pages/home_page/faq_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(FaqSection, () {
    Future<void> pumpFaqSection(WidgetTester tester) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: FaqSection(),
        ),
      );
    }

    testGoldens('renders as expected', (tester) async {
      await pumpFaqSection(tester);

      await multiScreenGolden(tester, 'faq_section');
    });

    testGoldens('renders answers as expeceted', (tester) async {
      await pumpFaqSection(tester);

      await tester.tap(find.text('Is the source code of AnkiGPT public?'));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'faq_section_answer');
    });
  });
}
