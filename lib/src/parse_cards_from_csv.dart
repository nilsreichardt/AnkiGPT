import 'package:ankigpt/src/card.dart';
import 'package:fast_csv/fast_csv.dart' as fast_csv;

List<Card> parseCardsFromCsv(String file) {
  final csvLines = fast_csv.parse(file);
  return csvLines.map((line) => Card(line[0], line[1])).toList();
}
