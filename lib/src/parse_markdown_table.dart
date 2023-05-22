import 'package:ankigpt/src/card.dart';

List<Card> parseMarkdownTable(String markdownTable) {
  List<Card> questions = [];

  List<String> lines = markdownTable.split('\n');

  // Remove leading and trailing '|' characters
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();
    if (lines[i].startsWith('|')) {
      lines[i] = lines[i].substring(1);
    }
    if (lines[i].endsWith('|')) {
      lines[i] = lines[i].substring(0, lines[i].length - 1);
    }
  }

  // Parse table header
  List<String> headerCells =
      lines[0].split('|').map((cell) => cell.trim()).toList();

  // Find column indices for 'Question' and 'Answer'
  int questionIndex = headerCells.indexOf('Question');
  int answerIndex = headerCells.indexOf('Answer');

  // Parse table rows
  for (int i = 2; i < lines.length; i++) {
    List<String> cells =
        lines[i].split('|').map((cell) => cell.trim()).toList();
    if (cells.length >= 2 && questionIndex != -1 && answerIndex != -1) {
      String question = cells[questionIndex];
      String answer = cells[answerIndex];
      questions.add(Card(question, answer));
    }
  }

  return questions;
}
