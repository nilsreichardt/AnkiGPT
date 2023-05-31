import 'dart:math';

import 'package:ankigpt/firebase_options.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/buy_provider.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/controls_view_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/memory_output_provider.dart';
import 'package:ankigpt/src/providers/logger/provider_logger_observer.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  usePathUrlStrategy();

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
        leading: const Padding(
          padding: EdgeInsets.all(12),
          child: _Logo(),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const _Title(),
        actions: const [
          OthersOptions(),
        ],
      ),
      bottomNavigationBar: const Footer(),
      body: SingleChildScrollView(
        child: MaxWidthConstrainedBox(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 20,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: const [
                    SizedBox(height: 12),
                    InputBox(),
                    SizedBox(height: 12),
                    Controls(),
                    SizedBox(height: 12),
                    Results(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return Text('AnkiGPT${hasPlus ? ' Plus' : ''}');
  }
}

class _Logo extends ConsumerWidget {
  const _Logo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onDoubleTap: () {
        final hasPlus = ref.read(hasPlusProvider);
        ref.read(hasPlusProvider.notifier).state = !hasPlus;
      },
      child: SvgPicture.asset(
        'assets/logo/raw_logo.svg',
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSmartphone = MediaQuery.of(context).size.width < 550;
    if (isSmartphone) {
      return Column(
        children: [
          const SlideContextField(),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const _UploadFileButton(),
          ),
        ],
      );
    }

    return const Row(
      children: [
        Expanded(
          child: SlideContextField(),
        ),
        SizedBox(width: 12),
        _UploadFileButton(),
      ],
    );
  }
}

class _UploadFileButton extends StatelessWidget {
  const _UploadFileButton();

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(12));
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => showDialog(
        context: context,
        builder: (context) => const _PlusDialog(),
      ),
      child: Material(
        borderRadius: borderRadius,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: const Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(Icons.upload_file),
              Text('Upload PDF file'),
              SizedBox(height: 8),
              PlusBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class PlusBadge extends StatelessWidget {
  const PlusBadge({
    super.key,
    this.withText = true,
  });

  final bool withText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 14,
              ),
              if (withText) ...[
                const SizedBox(width: 6),
                const Text(
                  'PLUS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _PlusDialog extends ConsumerWidget {
  const _PlusDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("AnkiGPT Plus"),
      content: const Text('''Advantages:
* Generate 50, 100 or 150 cards at once
* Upload lecture slides and automatically generate flashcards
* Premium support

Lifetime: €9.99 (no subscription)'''),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            final parameters = <String, String>{
              'subject': '💎 AnkiGPT Premium',
              'body':
                  'Hey!\n\nI would like to buy AnkiGPT for €9.99.\n\nBest regards'
            };
            final mailto = Uri(
              scheme: 'mailto',
              path: 'support@ankigpt.wtf',
              query: parameters.entries
                  .map((e) =>
                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                  .join('&'),
            );
            launchUrl(mailto);

            ref.read(buyProvider);
          },
          child: const Text('BUY'),
        ),
      ],
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
              loading: (cards, language) => _ResultList(cards: cards),
              error: (error, cards, language) => Column(
                children: [
                  ErrorText(text: error),
                  const SizedBox(height: 12),
                  _ResultList(cards: cards)
                ],
              ),
              success: (cards, url, language) => _ResultList(cards: cards),
              orElse: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({
    Key? key,
    required this.cards,
  }) : super(key: key);

  final List<AnkiCard> cards;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 20,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              for (final card in cards)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ResultCard(card: card),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatefulWidget {
  const ResultCard({
    Key? key,
    required this.card,
  }) : super(key: key);

  final AnkiCard card;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool hovering = false;
  int randomNumber = 0;

  void switchHovering() {
    setState(() {
      hovering = !hovering;

      // We need to add a random number to the key to prevent having two widgets
      // with the same key when the user hovers over the card multiple times. If
      // the user hovers over the same card multiple times, the widget with the
      // old key will still be in the tree because of the animation.
      randomNumber = Random().nextInt(1000000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => switchHovering(),
      onExit: (_) => switchHovering(),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.card.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Opacity(
                      key: ValueKey('$randomNumber + $hovering'),
                      opacity: hovering ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !hovering,
                        child: Row(
                          children: [
                            IconButton(
                              tooltip: 'Dislike, if this is a bad card.',
                              iconSize: 15,
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_down),
                            ),
                            IconButton(
                              tooltip: 'Like, if this is a good card.',
                              iconSize: 15,
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_up),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                widget.card.answer,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: TutorialVideoPlayer(
        aspectRatio: 16 / 9,
        videoUrl:
            'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Ftutorial.mp4?alt=media&token=efcd7c72-ed7f-45b1-8e51-1913ac03cb26',
      ),
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
            'Copy the text of 2 - 10 slides of the lecture and paste it here. Supports nearly all langauges (e.g. English, French, Spanish, German, etc.).',
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
  five,
  ten,
  twenty,
  fifty,
  hundred,
  hundredFifty;

  int toInt() {
    switch (this) {
      case CardGenrationSize.five:
        return 5;
      case CardGenrationSize.ten:
        return 10;
      case CardGenrationSize.twenty:
        return 20;
      case CardGenrationSize.fifty:
        return 50;
      case CardGenrationSize.hundred:
        return 100;
      case CardGenrationSize.hundredFifty:
        return 150;
    }
  }

  String getUiText() {
    return '${toInt()} cards';
  }

  String getDurationText() {
    switch (this) {
      case CardGenrationSize.five:
        return '~ 1 - 2 min';
      case CardGenrationSize.ten:
        return '~ 1 - 2 min';
      case CardGenrationSize.twenty:
        return '~ 3 - 5 min';
      case CardGenrationSize.fifty:
        return '~ 5 - 10 min';
      case CardGenrationSize.hundred:
        return '~ 10 min';
      case CardGenrationSize.hundredFifty:
        return '~ 15 min';
    }
  }

  bool isPlus() {
    switch (this) {
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hundredFifty:
        return true;
      default:
        return false;
    }
  }
}

class Select extends ConsumerWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    return SizedBox(
      width: 152,
      child: DropdownButtonFormField<CardGenrationSize>(
        value: ref.watch(cardGenrationSizeProvider),
        items: [
          ...CardGenrationSize.values.map(
            (c) => DropdownMenuItem(
              value: c,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.getUiText()),
                  if (!hasPlus && c.isPlus()) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: 38,
                      child: PlusBadge(
                        withText: false,
                      ),
                    )
                  ]
                ],
              ),
            ),
          )
        ],
        onChanged: (v) {
          if (v != null) {
            if (!hasPlus && v.isPlus()) {
              showDialog(
                context: context,
                builder: (_) => const _PlusDialog(),
              );
            }

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
    final size = ref.watch(cardGenrationSizeProvider);
    return Align(
      alignment: Alignment.centerRight,
      child: Tooltip(
        message:
            'Generating ${size.getUiText()} takes ${size.getDurationText()}',
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
                    if (e is PlusMembershipRequiredException) {
                      showDialog(
                        context: context,
                        builder: (_) => const _PlusDialog(),
                      );
                      return;
                    }

                    if (e is TooShortInputException) {
                      showDialog(
                        context: context,
                        builder: (context) => const TooLessInputDialog(),
                      );
                      return;
                    }

                    if (e is TooLongInputException) {
                      showDialog(
                        context: context,
                        builder: (context) => const TooLongInputDialog(),
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
      ),
    );
  }
}

class TooLessInputDialog extends StatelessWidget {
  const TooLessInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const _InvalidInputDialog(
      title: 'Too short!',
      content:
          'Please add more text. If the text is too short, GPT cannot generate the flashcards.',
    );
  }
}

class TooLongInputDialog extends StatelessWidget {
  const TooLongInputDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _InvalidInputDialog(
      title: 'Too long!',
      content:
          'Your text is too long. If the text is too long, GPT cannot generate the flashcards. Use less than 15,000 characters.',
    );
  }
}

class _InvalidInputDialog extends StatelessWidget {
  const _InvalidInputDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
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
            label: const Text('Export to Anki'),
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
