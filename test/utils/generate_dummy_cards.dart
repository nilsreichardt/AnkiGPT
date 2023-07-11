import 'package:ankigpt/src/models/anki_card.dart';

/// Generates a list of [AnkiCard]s with the given [count] that are sorted by
/// their [createdAt] date.
List<AnkiCard> generateDummyCards(int count) {
  return List<AnkiCard>.generate(
    count,
    (index) => AnkiCard(
      answer: 'answer $index',
      question: 'question $index',
      createdAt: DateTime.now().add(Duration(minutes: index)),
      id: '$index',
    ),
  );
}
