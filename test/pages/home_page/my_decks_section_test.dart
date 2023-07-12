import 'dart:math';

import 'package:ankigpt/src/models/deck_preview.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

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
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
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

    testGoldens('renders as expected', (tester) async {
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
        ),
        DeckPreview.error(
          message: _generateString(random),
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
        ),
      ];
      await pumpMyDecksSection(tester, decks: decks);

      await multiScreenGolden(tester, 'my_decks_section');
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
