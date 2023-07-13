import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/models/watch_view.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(Controls, () {
    Future<void> pumpControls(
      WidgetTester tester, {
      WatchView view = const WatchView(),
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
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

    testAdaptiveWidgets('renders as expected before watching',
        (tester, variant) async {
      await pumpControls(tester, variant: variant);

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'controls_berfore_watching',
      );
    });
  });
}
