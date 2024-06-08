import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'import_from_gpt_controller.g.dart';

@Riverpod()
class ImportFromGptController extends _$ImportFromGptController {
  @override
  void build() {}

  final _parser = ImportFromGptParser();

  Future<SessionId> importFromGpt(String text) async {
    await _signInIfNeeded();

    final cards = _parser.parse(text);

    final sessionRepository = ref.read(sessionRepositoryProvider);
    final sessionId = await sessionRepository.importFromGpt(cards: cards);

    return sessionId;
  }

  Future<void> _signInIfNeeded() async {
    final userRepository = ref.read(userRepositoryProvider);
    if (!userRepository.isSignedIn()) {
      await userRepository.signIn();
    }
  }
}

typedef QuestionAnswer = (String, String);

class ImportFromGptParser {
  /// Parses the given text from a Markdown table into a list of question-answer
  /// pairs.
  ///
  /// Ignores lines that don't start with a pipe character.
  ///
  /// Example input:
  /// ```
  /// Hier sind 10 Karteikarten basierend auf den Inhalten des hochgeladenen Dokuments:
  ///
  /// | Frage | Antwort |
  /// | --- | --- |
  /// | Was ist die Dezimalzahl (mit Vorzeichen) für die 8-Bit Binärzahl 1111 1111? | -1 |
  /// | Wie wird die Binärzahl 0010 1010 im Hexadezimalsystem dargestellt? | 0x2a |
  /// | Was passiert, wenn das Ergebnis der Funktion `pyramid_number` nicht in 64 Bit darstellbar ist? | Es wird `2^64 - 1` zurückgegeben. |
  ///
  /// Ich werde diese Karteikarten nun zu Anki importieren.
  ///
  /// Die Karteikarten wurden erfolgreich erstellt und können über den folgenden Link auf Anki importiert werden:
  ///
  /// [Grundlagenpraktikum: Rechnerarchitektur Blatt 1](https://ankigpt.help/deck/67783224-cc1d-4635-9edf-a73a61f924d8)
  /// Möchten Sie weitere Karteikarten für dasselbe Dokument erstellen?
  /// ```
  ///
  /// The above text would be parsed into the following list:
  /// ```dart
  /// [
  ///  ('Was ist die Dezimalzahl (mit Vorzeichen) für die 8-Bit Binärzahl 1111 1111?', '-1'),
  ///  ('Wie wird die Binärzahl 0010 1010 im Hexadezimalsystem dargestellt?', '0x2a'),
  ///  ('Was passiert, wenn das Ergebnis der Funktion `pyramid_number` nicht in 64 Bit darstellbar ist?', 'Es wird `2^64 - 1` zurückgegeben.')
  /// ]
  /// ```
  List<Map<String, String>> parse(String text) {
    final lines = text.split('\n');
    final cards = <Map<String, String>>[];

    // Skip the first two lines, which are not part of the table itself. They
    // are just a header and a separator.
    final markdownLines = lines.where((line) => line.startsWith('|')).toList();
    for (int i = 2; i < markdownLines.length; i++) {
      final line = markdownLines[i];
      final cells = line
          .split('|')
          .map((cell) => cell.trim())
          .where((cell) => cell.isNotEmpty)
          .toList();

      if (cells.length == 2) {
        final front = cells[0];
        final back = cells[1];

        if (front == "---" || back == "---") {
          continue;
        }

        cards.add({
          'front': front.replaceAll('<br>', '\n'),
          'back': back.replaceAll('<br>', '\n'),
        });
      }
    }

    return cards;
  }
}
