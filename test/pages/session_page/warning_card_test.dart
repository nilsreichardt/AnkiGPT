import 'package:ankigpt/src/pages/session_page/warning_card.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/pump_ankigpt_app.dart';
import 'warning_card_test.mocks.dart';

class MockSharedPreferencesAcccesser extends SharedPreferencesAccesser {
  final MockSharedPreferences? _sharedPreferences;

  MockSharedPreferencesAcccesser(this._sharedPreferences);

  @override
  SharedPreferences? build() {
    return _sharedPreferences;
  }
}

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  Future<void> pumpWarningDoubleCheckCard(
    WidgetTester tester, {
    bool shouldShowCard = true,
  }) async {
    await pumpAnkiGptApp(
      tester: tester,
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

    testGoldens('renders as expected', (tester) async {
      await pumpWarningDoubleCheckCard(tester);

      await screenMatchesGolden(tester, 'warning_double_check_card');
    });
  });
}
