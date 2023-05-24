import 'package:ankigpt/firebase_options.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
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
      body: const SingleChildScrollView(
        child: MaxWidthConstrainedBox(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Text("Side is not working yet..."),
                SizedBox(height: 12),
                SlideContextField(),
                SizedBox(height: 12),
                Controls(),
                SizedBox(height: 12),
                Results(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Results extends ConsumerWidget {
  const Results({super.key});

  String buildMarkdown(List<AnkiCard> cards) {
    String markdown = '| Frage | Antwort |\n| --- | --- |\n';
    for (final card in cards) {
      markdown += '| ${card.front} | ${card.back} |\n';
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
        child: Container(
          key: ValueKey(state),
          child: state.maybeWhen(
            loading: (cards) => MarkdownBody(
              selectable: true,
              softLineBreak: true,
              data: buildMarkdown(cards),
            ),
            success: (cards) => MarkdownBody(
              selectable: true,
              softLineBreak: true,
              data: buildMarkdown(cards),
            ),
            orElse: () => const SizedBox(),
          ),
        ));
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
        hintText: 'Kopiere hier den Inhalt der Vorlesungsfolie.',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Select(),
        Expanded(flex: 3, child: const SizedBox.shrink()),
        LoadingButton(isVisible: view.isGenerating),
        DownloadButton(isVisible: view.isDownloadButtonVisible),
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

  String getUiText() {
    switch (this) {
      case CardGenrationSize.three:
        return '3 Karten';
      case CardGenrationSize.six:
        return '6 Karten';
      case CardGenrationSize.nine:
        return '9 Karten';
      case CardGenrationSize.fifteen:
        return '15 Karten';
    }
  }
}

class Select extends ConsumerWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 1,
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
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                ref.read(generateStateProvider.notifier).submit();
              }
            : null,
        child: const Text('Generieren'),
      ),
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
          child: Opacity(
            key: ValueKey(isFinished),
            opacity: isVisible ? 1 : 0,
            child: IgnorePointer(
              ignoring: !isVisible,
              child: IconButton(
                tooltip: isFinished ? 'Download' : 'Download gleich möglich...',
                onPressed: isFinished ? () {} : null,
                icon: const Icon(Icons.download),
              ),
            ),
          )),
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
                message: 'Erstelle Karte...',
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
