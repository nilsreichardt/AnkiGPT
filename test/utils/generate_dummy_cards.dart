import 'package:ankigpt/src/models/anki_card.dart';

/// Generates a list of [AnkiCard]s with the given [count] that are sorted by
/// their [createdAt] date.
List<AnkiCard> generateDummyCards(int count) {
  final fixDate = DateTime(2021, 1, 1);
  return List<AnkiCard>.generate(
    count,
    (index) => AnkiCard(
      answer: 'answer $index',
      question: 'question $index',
      createdAt: fixDate.add(Duration(minutes: index)),
      id: '$index',
    ),
  );
}
