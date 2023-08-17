import 'dart:math';

import 'package:adaptive_test/adaptive_test.dart';
import 'package:ankigpt/src/models/deck_preview.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/pump_ankigpt_app.dart';

void main() {
  group(MyDecksSection, () {
    late Random random;

    setUp(() {
      random = Random(42);
    });

    Future<void> pumpMyDecksSection(
      WidgetTester tester, {
      List<DeckPreview> decks = const [],
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
          deckListProvider.overrideWith((ref) => Stream.value(decks)),
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
          numberOfCards: random.nextInt(100),
        ),
        DeckPreview.loading(
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
          sessionId: _generateString(random),
        ),
        DeckPreview.error(
          message: _generateString(random),
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
          sessionId: _generateString(random),
        ),
      ];
      await pumpMyDecksSection(
        tester,
        decks: decks,
        variant: variant,
      );

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
