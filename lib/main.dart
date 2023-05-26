import 'package:ankigpt/firebase_options.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/controls_view_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/memory_output_provider.dart';
import 'package:ankigpt/src/providers/logger/provider_logger_observer.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // We need to create a provider container because at this point, we don't
  // have any widget or provider scope set. Therefore, we can only access
  // provider through the container.
  final container = ProviderContainer();

  final memoryOutput = container.read(memoryOutputProvider);
  final logger = container.read(loggerProvider);

  FlutterError.onError = (details) {
    logger.e('FlutterError.onError', details.exception, details.stack);
  };

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(
    observers: [
      ProviderLoggerObserver(logger),
    ],
    overrides: [
      memoryOutputProvider.overrideWithValue(memoryOutput),
      loggerProvider.overrideWithValue(logger),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiGPT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00FF7F)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/imprint': (context) => const ImprintPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AnkiGPT'),
        actions: const [
          OthersOptions(),
        ],
      ),
      body: SingleChildScrollView(
        child: MaxWidthConstrainedBox(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                MarkdownBody(
                  data:
                      "Flashcards may contain incorrect information! Click [here](https://wa.me/4915229504121) to give feedback or get support.",
                  onTapLink: (
                    text,
                    href,
                    _,
                  ) {
                    if (href == null) return;
                    launchUrl(Uri.parse(href));
                  },
                ),
                const SizedBox(height: 12),
                const SlideContextField(),
                const SizedBox(height: 12),
                const Controls(),
                const SizedBox(height: 12),
                const Results(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorText extends ConsumerWidget {
  const ErrorText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      'Error while generating ("$text"). Please retry.',
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}

class Results extends ConsumerWidget {
  const Results({super.key});

  String buildMarkdown(List<AnkiCard> cards, {required bool isCompleted}) {
    String markdown = '| Question | Answer |\n| --- | --- |\n';
    for (final card in cards) {
      markdown += '| ${card.question} | ${card.answer} |\n';
    }

    if (!isCompleted) {
      markdown += '| ... | ... |\n';
    }

    return markdown;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateStateProvider);
    return AnimatedSwitcher(
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: state.maybeWhen(
        initial: (_) => const Tutorial(),
        orElse: () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.maybeWhen(
              error: (_, __, language) => _LanguageText(language: language),
              success: (_, __, language) => _LanguageText(language: language),
              loading: (_, language) => _LanguageText(language: language),
              orElse: () => const SizedBox.shrink(),
            ),
            state.maybeWhen(
              loading: (cards, language) => MarkdownBody(
                selectable: true,
                softLineBreak: true,
                data: buildMarkdown(cards, isCompleted: false),
              ),
              error: (error, cards, language) => Column(
                children: [
                  ErrorText(text: error),
                  const SizedBox(height: 12),
                  MarkdownBody(
                    selectable: true,
                    softLineBreak: true,
                    data: buildMarkdown(cards, isCompleted: false),
                  ),
                ],
              ),
              success: (cards, url, language) => MarkdownBody(
                selectable: true,
                softLineBreak: true,
                data: buildMarkdown(cards, isCompleted: true),
              ),
              orElse: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const TutorialVideoPlayer(
      aspectRatio: 16 / 9,
      videoUrl:
          'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Ftutorial.mp4?alt=media&token=efcd7c72-ed7f-45b1-8e51-1913ac03cb26',
    );
  }
}

class _LanguageText extends StatelessWidget {
  const _LanguageText({required this.language});

  final Language? language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        'Detected language: ${language == null ? '...' : language!.getDisplayName()}',
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}

class SlideContextField extends ConsumerWidget {
  const SlideContextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: ref.read(slideTextFieldControllerProvider),
      minLines: 5,
      maxLines: 10,
      decoration: const InputDecoration(
        hintText:
            'Copy the text of 2 - 10 slides of the lecture and paste it here. Supported langauges: English and German.',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class Controls extends ConsumerWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(controlsViewProvider);
    final isSmartphone = MediaQuery.of(context).size.width < 530;
    if (isSmartphone) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Select(),
              const Expanded(child: SizedBox.shrink()),
              LoadingButton(isVisible: view.isGenerating),
              const SizedBox(width: 12),
              GenerateButton(isEnabled: view.isGeneratedButtonEnabled),
            ],
          ),
          const SizedBox(height: 16),
          DownloadButton(isVisible: view.isDownloadButtonVisible),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DownloadButton(isVisible: view.isDownloadButtonVisible),
        const Expanded(child: SizedBox.shrink()),
        LoadingButton(isVisible: view.isGenerating),
        const Select(),
        const SizedBox(width: 12),
        GenerateButton(isEnabled: view.isGeneratedButtonEnabled),
      ],
    );
  }
}

enum CardGenrationSize {
  three,
  six,
  nine,
  fifteen;

  int toInt() {
    switch (this) {
      case CardGenrationSize.three:
        return 3;
      case CardGenrationSize.six:
        return 6;
      case CardGenrationSize.nine:
        return 9;
      case CardGenrationSize.fifteen:
        return 15;
    }
  }

  String getUiText() {
    switch (this) {
      case CardGenrationSize.three:
        return '3 Cards';
      case CardGenrationSize.six:
        return '6 Cards';
      case CardGenrationSize.nine:
        return '9 Cards';
      case CardGenrationSize.fifteen:
        return '15 Cards';
    }
  }
}

class Select extends ConsumerWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 120,
      child: DropdownButtonFormField<CardGenrationSize>(
        value: ref.read(cardGenrationSizeProvider),
        items: [
          ...CardGenrationSize.values.map(
            (c) => DropdownMenuItem(
              value: c,
              child: Text(c.getUiText()),
            ),
          )
        ],
        onChanged: (v) {
          if (v != null) {
            ref.read(cardGenrationSizeProvider.notifier).state = v;
          }
        },
      ),
    );
  }
}

class GenerateButton extends ConsumerWidget {
  const GenerateButton({
    super.key,
    required this.isEnabled,
  });

  final bool isEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow),
        label: const Text('Generate'),
        onPressed: isEnabled
            ? () async {
                try {
                  final size = ref.read(cardGenrationSizeProvider);
                  await ref
                      .read(generateStateProvider.notifier)
                      .submit(size: size);
                } catch (e) {
                  if (e is TooShortInputException) {
                    showDialog(
                      context: context,
                      builder: (context) => const TooLessInputDialog(),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              }
            : null,
      ),
    );
  }
}

class TooLessInputDialog extends StatelessWidget {
  const TooLessInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Too short!'),
      content: const Text(
          'Please add more text. If the text is too short, GPT cannot generate the flashcards.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class DownloadButton extends ConsumerWidget {
  const DownloadButton({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(generateStateProvider);
    final isFinished = state is GenerationStateSuccess;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(isFinished),
          message: state.maybeWhen(
            loading: (_, __) =>
                'Still generating... Please wait a few seconds.',
            success: (_, __, ___) => 'Download as .csv file to import it',
            orElse: () => '',
          ),
          child: ElevatedButton.icon(
            label: const Text('Import to Anki'),
            onPressed: isFinished
                ? () {
                    final url = state.downloadUrl;
                    if (url == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Download failed.'),
                        ),
                      );
                      return;
                    }

                    launchUrl(Uri.parse(url));
                  }
                : null,
            icon: const Icon(Icons.download),
          ),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isVisible
          ? Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Tooltip(
                key: super.key,
                message: 'Generating Cards... Takes 30 - 90 seconds.',
                child: const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
