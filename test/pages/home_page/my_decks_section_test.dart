import 'dart:math';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/models/deck_preview.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

class MockDeckListController extends DeckListController {
  final DeckListState _state;

  MockDeckListController(this._state);

  @override
  DeckListState build() {
    ref.onDispose(dispose);
    return _state;
  }
}

void main() {
  group(MyDecksSection, () {
    late Random random;

    setUp(() {
      random = Random(42);
    });

    Future<void> pumpMyDecksSection(
      WidgetTester tester, {
      required DeckListState state,
      WindowConfigData? variant,
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        variant: variant,
        body: const SingleChildScrollView(
          child: MyDecksSection(
            isTesting: true,
          ),
        ),
        overrides: [
          deckListControllerProvider.overrideWith(
            () => MockDeckListController(state),
          ),
          hasPlusProvider.overrideWithValue(true)
        ],
      );
    }

    testAdaptiveWidgets('renders as expected', (tester, variant) async {
      final decks = [
        DeckPreview.created(
          questions: _generateQuestions(random),
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          sessionId: _generateString(random),
          model: Model.gpt3_5,
          numberOfCards: random.nextInt(100),
        ),
        DeckPreview.loading(
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
          sessionId: _generateString(random),
          model: Model.gpt3_5,
        ),
        DeckPreview.error(
          message: _generateString(random),
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
          sessionId: _generateString(random),
          model: Model.gpt3_5,
        ),
      ];
      await pumpMyDecksSection(
        tester,
        state: DeckListLoaded(
          batches: {
            0: decks,
          },
          hasMore: true,
          hasLess: false,
        ),
        variant: variant,
      );
      await tester.pumpAndSettle();

      await tester.expectGolden<ProviderScope>(
        variant,
        suffix: 'my_decks_section',
      );
    });
  });
}

List<String> _generateQuestions(Random random) {
  return List.generate(
    random.nextInt(5),
    (_) => _generateString(random),
  );
}

String _generateString(Random random) {
  return List.generate(
    random.nextInt(10),
    (_) => String.fromCharCode(random.nextInt(26) + 97),
  ).join();
}
