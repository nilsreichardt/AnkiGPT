import 'package:ankigpt/src/pages/widgets/ankigpt_logo.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnkiGptMembershipTextLogo ', () {
    testWidgets('should use the plus logo if the user has plus',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hasPlusProvider.overrideWithValue(true),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: AnkiGptMembershipTextLogo(),
            ),
          ),
        ),
      );

      expect(find.byType(AnkiGptPlusTextLogo), findsOneWidget);
    });

    testWidgets('should use the plus logo if the user has plus',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hasPlusProvider.overrideWithValue(false),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: AnkiGptMembershipTextLogo(),
            ),
          ),
        ),
      );

      expect(find.byType(AnkiGptTextLogo), findsOneWidget);
    });

    testWidgets('should show "Home" as tooltip message', (tester) async {
      final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hasPlusProvider.overrideWithValue(false),
          ],
          child: MaterialApp(
            theme: ankigptTheme,
            home: Scaffold(
              body: AnkiGptMembershipTextLogo(
                tooltipKey: tooltipKey,
              ),
            ),
          ),
        ),
      );
      tooltipKey.currentState?.ensureTooltipVisible();

      // Trigger a long press to display the tooltip.
      await tester.longPress(find.byType(Tooltip));

      // Rebuild the widget after the tooltip has been displayed.
      await tester.pump(const Duration(seconds: 2));

      // Expect that the Tooltip's message is the correct one.
      expect(find.text('Home'), findsOneWidget);
    });
  });
}
