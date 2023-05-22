import 'dart:convert';
import 'dart:io';

import 'package:ankigpt/src/parse_cards_from_csv.dart';
import 'package:ankigpt/src/parse_markdown_table.dart';
import 'package:ankigpt/src/card.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

final outputPath = 'output.csv';
final slidePath = 'slides.txt';
final promptTemplatePath = 'prompt_template.txt';

final httpClient = http.Client();
final verbose = false;

/// Generates a set of Anki cards and adds it to the output file.
Future<void> generateMoreAnkiCards() async {
  final numberOfMinCards = 10;
  int currentNumberOfCards = 0;

  while (currentNumberOfCards < numberOfMinCards) {
    final outputFile = File(outputPath);
    final List<Card> currentCards = [];

    if (await outputFile.exists()) {
      final output = await outputFile.readAsString();
      currentCards.addAll(parseCardsFromCsv(output));
      print('Found ${currentCards.length} existing cards.');
    }
    currentNumberOfCards = currentCards.length;

    if (currentNumberOfCards >= numberOfMinCards) {
      break;
    }

    final slideFile = File(slidePath);
    if (!slideFile.existsSync()) {
      print('No slides.txt file found. Please create one and add your slides.');
      exit(1);
    }

    final slides = await slideFile.readAsString();

    final promptTemplateFile = File(promptTemplatePath);
    final promptTemplate = await promptTemplateFile.readAsString();

    String prompt = promptTemplate.replaceAll('{{slidesContent}}', slides);
    if (currentNumberOfCards != 0) {
      prompt +=
          '\n\n Du hast bereits folgende Karten erstellt. Diese musst du nicht mehr hinzufügen:\n\n';
      prompt += currentCards.map((q) => '- ${q.question}').join('\n');
    }

    final answer = await callOpenAiApi(prompt);
    final newCards = parseMarkdownTable(answer);

    final lines = newCards.map((e) => [e.question, e.answer]).toList();

    String csv = const ListToCsvConverter().convert(lines);

    outputFile.writeAsString(
      '$csv\n',
      mode: FileMode.append,
    );
  }

  print("🎉 Done! You've created $currentNumberOfCards new cards.");
}

Future<String> callOpenAiApi(String prompt) async {
  final key = Platform.environment['OPENAI_KEY'];
  if (key == null) {
    throw Exception('OPENAI_KEY environment variable not set.');
  }

  if (verbose) {
    // print('Calling OpenAI API with prompt: $prompt');
  }

  final url = 'https://api.openai.com/v1/chat/completions';
  final response = await httpClient.post(
    Uri.parse(url),
    body: jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": prompt,
        }
      ]
    }),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    },
  );

  if (verbose) {
    print(
        'OpenAI API response: ${jsonDecode(utf8.decode(response.bodyBytes))}');
  }

  if (response.statusCode != 200) {
    throw Exception('OpenAI API returned status code ${response.statusCode}. '
        'Response body: ${response.body}');
  }

  return jsonDecode(
    utf8.decode(response.bodyBytes),
  )['choices'][0]['message']['content'];
}
