import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/watch_view.dart';
import 'package:ankigpt/src/pages/deck_page/result_section.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
      WindowConfigData? variant,
    }) async {
      const sessionId = 'session-id';
      await pumpAnkiGptApp(
        variant: variant,
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

    testAdaptiveWidgets('renders error cards on error as expected',
        (tester, variant) async {
      final cards = generateDummyCards(2);
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        error: 'some-error',
        sessionId: 'session-id',
        model: Model.gpt3_5,
      );
      await pumpResultSection(
        tester,
        variant: variant,
        view: view,
        cards: cards,
      );

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'result_error_cards',
      );
    });

    testAdaptiveWidgets('renders empty state as expected',
        (tester, variant) async {
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        sessionId: 'session-id',
        model: Model.gpt3_5,
      );
      await pumpResultSection(
        tester,
        variant: variant,
        view: view,
        cards: [],
      );

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'result_empty',
      );
    });

    testAdaptiveWidgets('renders as expected with cards',
        (tester, variant) async {
      final cards = generateDummyCards(50);
      const view = WatchView(
        downloadUrl: 'https://example.com',
        isLoading: false,
        language: Language.en,
        sessionId: 'session-id',
        model: Model.gpt3_5,
      );
      await pumpResultSection(
        tester,
        variant: variant,
        cards: cards,
        view: view,
      );

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'result_with_cards',
      );
    });
  });
}
