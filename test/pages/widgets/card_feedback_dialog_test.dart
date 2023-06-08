import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('CardLikeDialog', () {
    testGoldens('renders as expected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ankigptTheme,
          home: Scaffold(
            body: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () => showCardLikeDialog(context),
                child: const Text('Click'),
              );
            }),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'card_like_dialog');
    });
  });

  group('CardDislikeDialog', () {
    testGoldens('renders as expected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ankigptTheme,
          home: Scaffold(
            body: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () => showCardDislikeDialog(context),
                child: const Text('Click'),
              );
            }),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'card_dislike_dialog');
    });
  });
}
