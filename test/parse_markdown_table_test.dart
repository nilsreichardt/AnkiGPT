import 'package:ankigpt/src/parse_markdown_table.dart';
import 'package:ankigpt/src/card.dart';
import 'package:test/test.dart';

void main() {
  group('.parseMarkdownTable()', () {
    test('should correctly parse questions and answers', () {
      String markdownTable =
          "| Question | Answer |\n|---|---|\n| Die UG kann als Mini-GmbH bezeichnet werden. Wahr oder falsch? | Wahr |\n| Die Aktien einer Aktiengesellschaft müssen an der Börse gehandelt werden. Wahr oder falsch? | Falsch |";

      List<Card> questions = parseMarkdownTable(markdownTable);

      expect(questions.length, equals(2));

      expect(
          questions[0].question,
          equals(
              "Die UG kann als Mini-GmbH bezeichnet werden. Wahr oder falsch?"));
      expect(questions[0].answer, equals("Wahr"));

      expect(
          questions[1].question,
          equals(
              "Die Aktien einer Aktiengesellschaft müssen an der Börse gehandelt werden. Wahr oder falsch?"));
      expect(questions[1].answer, equals("Falsch"));
    });

    test('should handle missing columns gracefully', () {
      String markdownTable =
          "| Question | Option |\n|---|---|\n| Die UG kann als Mini-GmbH bezeichnet werden. Wahr oder falsch? | Wahr |\n| Die Aktien einer Aktiengesellschaft müssen an der Börse gehandelt werden. Wahr oder falsch? | Falsch |";

      List<Card> questions = parseMarkdownTable(markdownTable);

      expect(questions.length, equals(0));
    });

    test('should handle empty table gracefully', () {
      String markdownTable = "";

      List<Card> questions = parseMarkdownTable(markdownTable);

      expect(questions.length, equals(0));
    });
  });
}
