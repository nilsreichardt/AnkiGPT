import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/watch_view.dart';
import 'package:ankigpt/src/pages/session_page/result_section.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/mock_shared_preferences_accesser.dart';
import '../../mocks/mock_shared_preferences_accesser.mocks.dart';
import '../../utils/generate_dummy_cards.dart';
import '../../utils/pump_ankigpt_app.dart';

class MockCardsList extends CardsList {
  final List<AnkiCard> _cards;

  MockCardsList(this._cards);

  @override
  List<AnkiCard> build() {
    return _cards;
  }
}

class MockWatch extends Watch {
  final WatchView _view;

  MockWatch(this._view);

  @override
  WatchView build(SessionId sessionId) {
    return _view;
  }
}

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  group(ResultSection, () {
    Future<void> pumpResultSection(
      WidgetTester tester, {
      List<AnkiCard> cards = const [],
      WatchView view = const WatchView(),
    }) async {
      const sessionId = 'session-id';
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: ResultSection(),
          ),
        ),
        overrides: [
          cardsListProvider.overrideWith(() => MockCardsList(cards)),
          watchProvider(sessionId).overrideWith(() => MockWatch(view)),
          sharedPreferencesAccesserProvider.overrideWith(
            () => MockSharedPreferencesAcccesser(MockSharedPreferences()),
          ),
          sessionIdProvider.overrideWithValue(sessionId)
        ],
      );
    }

    testGoldens('renders error cards on error as expected', (tester) async {
      final cards = generateDummyCards(2);
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        error: 'some-error',
        sessionId: 'session-id',
      );
      await pumpResultSection(
        tester,
        view: view,
        cards: cards,
      );

      await screenMatchesGolden(tester, 'result_section_error');
    });

    testGoldens('renders empty state as expected', (tester) async {
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        sessionId: 'session-id',
      );
      await pumpResultSection(
        tester,
        view: view,
        cards: [],
      );

      await screenMatchesGolden(tester, 'result_section_empty');
    });

    testGoldens('renders as exepcted with cards', (tester) async {
      final cards = generateDummyCards(50);
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        sessionId: 'session-id',
      );
      await pumpResultSection(
        tester,
        cards: cards,
        view: view,
      );

      await multiScreenGolden(tester, 'result_section_with_cards');
    });
  }, skip: 'https://github.com/rrousselGit/riverpod/issues/2047');
}
