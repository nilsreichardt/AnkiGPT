import 'dart:math';

import 'package:ankigpt/src/models/history_deck.dart';
import 'package:ankigpt/src/pages/home_page/my_decks_section.dart';
import 'package:ankigpt/src/providers/history_deck_list_provider.dart';
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
      List<HistoryDeck> decks = const [],
    }) async {
      await pumpAnkiGptApp(
        tester: tester,
        body: const SingleChildScrollView(
          child: MyDecksSection(
            isTesting: true,
          ),
        ),
        overrides: [
          historyDeckListProvider.overrideWith((ref) => Stream.value(decks)),
        ],
      );
    }

    testGoldens('renders as expected', (tester) async {
      final decks = [
        HistoryDeck.created(
          questions: _generateQuestions(random),
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          sessionId: _generateString(random),
          numberOfCards: random.nextInt(100),
        ),
        HistoryDeck.loading(
          createdAt: DateTime(2023, 1, 1),
          name: _generateString(random),
          numberOfCards: random.nextInt(100),
        ),
        HistoryDeck.error(
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
