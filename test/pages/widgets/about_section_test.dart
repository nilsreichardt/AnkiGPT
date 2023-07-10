import 'package:ankigpt/src/pages/home_page/about_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(AboutSection, () {
    Future<void> pumpAboutSection(WidgetTester tester) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: AboutSection(),
        ),
      );
    }

    testGoldens('renders as expected', (tester) async {
      await pumpAboutSection(tester);

      await multiScreenGolden(tester, 'about_section');
    });
  });
}
