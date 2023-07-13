import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group('CardLikeDialog', () {
    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        body: Builder(builder: (context) {
          return Center(
            child: ElevatedButton(
              onPressed: () => showCardLikeDialog(
                context,
                cardId: '',
                sessionId: '',
              ),
              child: const Text('Click'),
            ),
          );
        }),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.expectGolden<ProviderScope>(variant, suffix: 'like_dialog');
    });
  });

  group('CardDislikeDialog', () {
    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        body: Builder(builder: (context) {
          return Center(
            child: ElevatedButton(
              onPressed: () => showCardDislikeDialog(
                context,
                cardId: '',
                sessionId: '',
              ),
              child: const Text('Click'),
            ),
          );
        }),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'dislike_dialog',
      );
    });
  });
}
