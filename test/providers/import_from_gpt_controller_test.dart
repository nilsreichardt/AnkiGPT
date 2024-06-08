import 'package:ankigpt/src/providers/import_from_gpt_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ImportFromGptParser, () {
    late ImportFromGptParser parser;

    setUp(() {
      parser = ImportFromGptParser();
    });

    test('single table', () {
      const input =
          '''Hier sind 10 Karteikarten basierend auf den Inhalten des hochgeladenen Dokuments:

| Frage | Antwort |
| --- | --- |
| Was ist die Dezimalzahl (mit Vorzeichen) für die 8-Bit Binärzahl 1111 1111? | -1 |
| Wie wird die Binärzahl 0010 1010 im Hexadezimalsystem dargestellt? | 0x2a |
| Was passiert, wenn das Ergebnis der Funktion `pyramid_number` nicht in 64 Bit darstellbar ist? | Es wird `2^64 - 1` zurückgegeben.<br>Neue Zeile |

Ich werde diese Karteikarten nun zu Anki importieren.

Die Karteikarten wurden erfolgreich erstellt und können über den folgenden Link auf Anki importiert werden:

[Grundlagenpraktikum: Rechnerarchitektur Blatt 1](https://ankigpt.help/deck/67783224-cc1d-4635-9edf-a73a61f924d8)
Möchten Sie weitere Karteikarten für dasselbe Dokument erstellen?
''';

      final cards = parser.parse(input);

      expect(cards, [
        {
          "front":
              'Was ist die Dezimalzahl (mit Vorzeichen) für die 8-Bit Binärzahl 1111 1111?',
          "back": '-1'
        },
        {
          "front":
              'Wie wird die Binärzahl 0010 1010 im Hexadezimalsystem dargestellt?',
          "back": '0x2a'
        },
        {
          "front":
              'Was passiert, wenn das Ergebnis der Funktion `pyramid_number` nicht in 64 Bit darstellbar ist?',
          "back": 'Es wird `2^64 - 1` zurückgegeben.\nNeue Zeile'
        }
      ]);
    });
  });
}
