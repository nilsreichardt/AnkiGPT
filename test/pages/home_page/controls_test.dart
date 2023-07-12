import 'package:ankigpt/src/models/watch_view.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(Controls, () {
    Future<void> pumpControls(
      WidgetTester tester, {
      WatchView view = const WatchView(),
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const MaxWidthConstrainedBox(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Controls(),
              ],
            ),
          ),
        ),
      );
    }

    testGoldens('renders as expected before watching', (tester) async {
      await pumpControls(tester);

      await multiScreenGolden(tester, 'controls_before_watching');
    });
  });
}
