import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/pages/session_page/warning_card.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_shared_preferences_accesser.dart';
import '../../mocks/mock_shared_preferences_accesser.mocks.dart';
import '../../utils/pump_ankigpt_app.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  Future<void> pumpWarningDoubleCheckCard(
    WidgetTester tester, {
    bool shouldShowCard = true,
    WindowConfigData? variant,
  }) async {
    await pumpAnkiGptApp(
      tester: tester,
      variant: variant,
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            WarningDoubleCheckCard(),
          ],
        ),
      ),
      overrides: [
        sharedPreferencesAccesserProvider.overrideWith(
          () => MockSharedPreferencesAcccesser(mockSharedPreferences),
        )
      ],
    );
  }

  group(WarningDoubleCheckCard, () {
    testWidgets('does not show the card if has hidden the card',
        (tester) async {
      when(mockSharedPreferences.getBool('showWarningCard')).thenReturn(false);

      await pumpWarningDoubleCheckCard(tester);

      expect(find.byKey(const ValueKey('warning-card')), findsNothing);
    });

    testWidgets('shows the card if has not hidden the card', (tester) async {
      await pumpWarningDoubleCheckCard(tester);

      expect(find.byKey(const ValueKey('warning-card')), findsOneWidget);
    });

    testWidgets('hides the card when presses X', (tester) async {
      await pumpWarningDoubleCheckCard(tester);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('warning-card')), findsNothing);
    });

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      await pumpWarningDoubleCheckCard(tester, variant: variant);

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'show_warning_card',
      );
    });
  });
}
