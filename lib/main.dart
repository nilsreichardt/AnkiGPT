import 'dart:math';

import 'package:ankigpt/firebase_options_dev.dart' as dev;
import 'package:ankigpt/firebase_options_prod.dart' as prod;
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/flavor.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/history_section.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/other_options.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/buy_provider.dart';
import 'package:ankigpt/src/providers/card_feedback_status_provider.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/controls_view_provider.dart';
import 'package:ankigpt/src/providers/dislike_provider.dart';
import 'package:ankigpt/src/providers/flavor_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/like_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/memory_output_provider.dart';
import 'package:ankigpt/src/providers/logger/provider_logger_observer.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logger/logger.dart';
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
  final flavor = _getFlavor(logger);

  FlutterError.onError = (details) {
    logger.e('FlutterError.onError', details.exception, details.stack);
  };

  await _initFirebase(flavor);

  runApp(ProviderScope(
    observers: [
      ProviderLoggerObserver(logger),
    ],
    overrides: [
      memoryOutputProvider.overrideWithValue(memoryOutput),
      loggerProvider.overrideWithValue(logger),
      flavorProvider.overrideWithValue(flavor),
    ],
    child: const MyApp(),
  ));
}

Flavor _getFlavor(Logger logger) {
  final flavor = Flavor.values
      .byName(const String.fromEnvironment('FLAVOR', defaultValue: 'prod'));
  logger.i('Flavor: ${flavor.name}');
  return flavor;
}

Future<FirebaseApp> _initFirebase(Flavor flavor) async {
  switch (flavor) {
    case Flavor.dev:
      return Firebase.initializeApp(
          options: dev.DefaultFirebaseOptions.currentPlatform);
    case Flavor.prod:
      return Firebase.initializeApp(
          options: prod.DefaultFirebaseOptions.currentPlatform);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnkiGPT',
      theme: ankigptTheme,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
    return Tooltip(
      message: 'Home',
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ref.read(generateNotifierProvider.notifier).reset();
        },
        onDoubleTap: () => ref.read(hasPlusProvider.notifier).toggle(),
        child: SvgPicture.asset(
          'assets/logo/raw_logo.svg',
        ),
      ),
    );
  }
}

class InputBox extends ConsumerWidget {
  const InputBox({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedFile = ref.watch(pickedFileProvider);
    final hasPickedFile = pickedFile != null;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: Container(
        key: ValueKey(hasPickedFile),
        child: hasPickedFile
            ? const _PickedFileButton()
            : () {
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
              }(),
      ),
    );
  }
}

class _UploadFileButton extends ConsumerWidget {
  const _UploadFileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = BorderRadius.all(Radius.circular(12));
    final hasPlus = ref.watch(hasPlusProvider);
    return InkWell(
      borderRadius: borderRadius,
      onTap: () {
        final hasPlus = ref.read(hasPlusProvider);
        if (!hasPlus) {
          showDialog(
            context: context,
            builder: (context) => const _PlusDialog(),
          );
          return;
        }

        ref.read(generateNotifierProvider.notifier).pickFile();
      },
      child: Material(
        borderRadius: borderRadius,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Icon(Icons.upload_file),
              SizedBox(height: hasPlus ? 13 : 0),
              const Text('Upload PDF file'),
              SizedBox(height: hasPlus ? 13 : 8),
              if (!hasPlus) const PlusBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickedFileButton extends ConsumerWidget {
  const _PickedFileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = BorderRadius.all(Radius.circular(12));
    final pickedFile = ref.watch(pickedFileProvider);
    final isLoading =
        ref.watch(generateNotifierProvider) is GenerationStateLoading;
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: isLoading
            ? null
            : () {
                final hasPlus = ref.read(hasPlusProvider);
                if (!hasPlus) {
                  showDialog(
                    context: context,
                    builder: (context) => const _PlusDialog(),
                  );
                  return;
                }

                ref.read(generateNotifierProvider.notifier).pickFile();
              },
        child: Material(
          borderRadius: borderRadius,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 40, 12, 40),
                child: Column(
                  children: [
                    const Icon(Icons.upload_file),
                    const SizedBox(height: 13),
                    Text(pickedFile?.name ?? 'File picked.'),
                    const SizedBox(height: 13),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  tooltip:
                      'Remove file${isLoading ? ' (disabled while loading)' : ''}',
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(generateNotifierProvider.notifier)
                              .clearPickedFile();
                        },
                  icon: const Icon(Icons.delete),
                ),
              ),
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
    return MarkdownBody(
      data:
          'Error while generating ("$text"). Please retry or contact [support](https://wa.me/4915229504121).',
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class Results extends ConsumerWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateNotifierProvider);
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
        initial: (_) {
          final isSignedIn = ref.watch(isSignedInProvider);
          if (isSignedIn) {
            return const HistorySection();
          }

          return const Tutorial();
        },
        orElse: () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state.maybeWhen(
              error: (_, __, ___, language) =>
                  _LanguageText(language: language),
              success: (_, __, ___, language) =>
                  _LanguageText(language: language),
              loading: (_, ___, language, ____) =>
                  _LanguageText(language: language),
              orElse: () => const SizedBox.shrink(),
            ),
            state.maybeWhen(
              loading: (sessionId, cards, language, isUploadingFile) =>
                  cards.isEmpty
                      ? _LoadingCards(
                          isUploadFile: isUploadingFile,
                        )
                      : _ResultList(
                          sessionId: sessionId,
                          cards: cards,
                        ),
              error: (sessionId, error, cards, language) => Column(
                children: [
                  ErrorText(text: error),
                  const SizedBox(height: 12),
                  _ResultList(
                    cards: cards,
                    sessionId: sessionId,
                  )
                ],
              ),
              success: (sessionId, cards, url, language) => _ResultList(
                sessionId: sessionId,
                cards: cards,
              ),
              orElse: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCards extends StatelessWidget {
  const _LoadingCards({
    required this.isUploadFile,
  });

  final bool isUploadFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(
            key: ValueKey(isUploadFile),
            children: [
              const SizedBox(height: 12),
              const CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(
                isUploadFile
                    ? 'Uploading file...'
                    : 'Generating cards... This may take a few minutes.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Opacity(
                opacity: isUploadFile ? 0 : 1,
                child: Text(
                  'You can close the browser tab and come back later.',
                  style: TextStyle(
                    color: Colors.grey[500]!,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({
    Key? key,
    required this.cards,
    required this.sessionId,
  }) : super(key: key);

  final SessionId? sessionId;
  final List<AnkiCard> cards;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: AnimationLimiter(
        // We don't use cards.length as key because we don't want to animate all
        // cards when the list changes.
        key: ValueKey(cards.isEmpty),
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
                  child: ResultCard(
                    card: card,
                    sessionId: sessionId!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultCard extends ConsumerStatefulWidget {
  const ResultCard({
    Key? key,
    required this.card,
    required this.sessionId,
  }) : super(key: key);

  final AnkiCard card;
  final SessionId sessionId;

  @override
  ConsumerState<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends ConsumerState<ResultCard> {
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
      child: AnkiGptCard(
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
                  _Controls(
                    isHovering: hovering,
                    cardId: widget.card.id,
                    randomNumber: randomNumber,
                    sessionId: widget.sessionId,
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

class _Controls extends ConsumerWidget {
  const _Controls({
    required this.isHovering,
    required this.cardId,
    required this.randomNumber,
    required this.sessionId,
  });

  final bool isHovering;
  final CardId cardId;
  final SessionId sessionId;
  final int randomNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(cardFeedbackStatusControllerProvider(cardId));
    final hasLiked = status == CardFeedbackStatus.liked;
    final hasDisliked = status == CardFeedbackStatus.disliked;
    return Row(
      children: [
        if (hasLiked)
          _UndoLikeButton(
            cardId: cardId,
            sessionId: sessionId,
          ),
        if (hasDisliked)
          _UndoDislikeButton(
            cardId: cardId,
            sessionId: sessionId,
          ),
        if (!hasDisliked && !hasLiked)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Opacity(
              key: ValueKey('$randomNumber + $isHovering'),
              opacity: isHovering ? 1 : 0,
              child: IgnorePointer(
                ignoring: !isHovering,
                child: Row(
                  children: [
                    IconButton(
                      tooltip: 'Dislike, if this is a bad card.',
                      iconSize: 15,
                      onPressed: () {
                        ref
                            .read(cardFeedbackStatusControllerProvider(cardId)
                                .notifier)
                            .setStatus(CardFeedbackStatus.disliked);
                        ref.read(
                          dislikeCardProvider(
                            cardId: cardId,
                            sessionId: sessionId,
                          ),
                        );
                        showCardDislikeDialog(
                          context,
                          cardId: cardId,
                          sessionId: sessionId,
                        );
                      },
                      icon: const Icon(Icons.thumb_down),
                    ),
                    IconButton(
                      tooltip: 'Like, if this is a good card.',
                      iconSize: 15,
                      onPressed: () {
                        ref
                            .read(cardFeedbackStatusControllerProvider(cardId)
                                .notifier)
                            .setStatus(CardFeedbackStatus.liked);
                        ref.read(
                          likeCardProvider(
                            cardId: cardId,
                            sessionId: sessionId,
                          ),
                        );
                        showCardLikeDialog(
                          context,
                          sessionId: sessionId,
                          cardId: cardId,
                        );
                      },
                      icon: const Icon(Icons.thumb_up),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _UndoLikeButton extends ConsumerWidget {
  const _UndoLikeButton({
    required this.cardId,
    required this.sessionId,
  });

  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Undo like',
      iconSize: 15,
      onPressed: () {
        ref
            .read(cardFeedbackStatusControllerProvider(cardId).notifier)
            .setStatus(CardFeedbackStatus.notReviewed);
        ref.read(undoLikeCardProvider(cardId: cardId, sessionId: sessionId));
      },
      icon: const Icon(Icons.thumb_up),
    );
  }
}

class _UndoDislikeButton extends ConsumerWidget {
  const _UndoDislikeButton({
    required this.cardId,
    required this.sessionId,
  });

  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Undo dislike',
      iconSize: 15,
      onPressed: () {
        ref
            .read(cardFeedbackStatusControllerProvider(cardId).notifier)
            .setStatus(CardFeedbackStatus.notReviewed);
        ref.read(undoDislikeCardProvider(cardId: cardId, sessionId: sessionId));
      },
      icon: const Icon(Icons.thumb_down),
    );
  }
}

class Tutorial extends StatelessWidget {
  const Tutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: TutorialVideoPlayer(
          aspectRatio: 16 / 9,
          videoUrl:
              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Ftutorial.mp4?alt=media&token=efcd7c72-ed7f-45b1-8e51-1913ac03cb26',
        ),
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
              LoadingButton(isVisible: view.showLoadingIndicator),
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
        LoadingButton(isVisible: view.showLoadingIndicator),
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
  twoHundred,
  threeHundred,
  fiveHundred;

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
      case CardGenrationSize.twoHundred:
        return 200;
      case CardGenrationSize.threeHundred:
        return 300;
      case CardGenrationSize.fiveHundred:
        return 500;
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
      case CardGenrationSize.twoHundred:
        return '~ 15 min';
      case CardGenrationSize.threeHundred:
        return '~ 15 min';
      case CardGenrationSize.fiveHundred:
        return '~ 15 min';
    }
  }

  bool isPlus() {
    switch (this) {
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.twoHundred:
      case CardGenrationSize.threeHundred:
      case CardGenrationSize.fiveHundred:
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
        value: ref.watch(generationSizeProvider),
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

            ref.read(generationSizeProvider.notifier).set(v);
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
    final size = ref.watch(generationSizeProvider);
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
                    final size = ref.read(generationSizeProvider);
                    await ref
                        .read(generateNotifierProvider.notifier)
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
          'Your text is too long. If the text is too long, GPT cannot generate the flashcards. Use less than 10,000 characters.',
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
    final state = ref.read(generateNotifierProvider);
    final isFinished = state is GenerationStateSuccess;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(isFinished),
          message: state.maybeWhen(
            loading: (_, __, ___, ____) => 'Still generating... Please wait.',
            success: (_, __, ___, ____) => 'Download as .csv file to import it',
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
                message: 'Generating Cards...',
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
