import 'dart:async';
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
import 'package:ankigpt/src/pages/account_page.dart';
import 'package:ankigpt/src/pages/home_page.dart';
import 'package:ankigpt/src/pages/imprint.dart';
import 'package:ankigpt/src/pages/session_page.dart';
import 'package:ankigpt/src/pages/widgets/animated_swap.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/app_bar_widgets.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/history_section.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/pagination_control.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/buy_button_analytics.dart';
import 'package:ankigpt/src/providers/card_feedback_status_provider.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/controls_view_provider.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/dislike_provider.dart';
import 'package:ankigpt/src/providers/edit_answer_provider.dart';
import 'package:ankigpt/src/providers/edit_question_provider.dart';
import 'package:ankigpt/src/providers/flavor_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/is_signed_in_provider.dart';
import 'package:ankigpt/src/providers/like_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/logger/memory_output_provider.dart';
import 'package:ankigpt/src/providers/logger/provider_logger_observer.dart';
import 'package:ankigpt/src/providers/scroll_controller_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:ankigpt/src/providers/search_text_field_controller.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:ankigpt/src/providers/show_warning_card.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/total_cards_counter_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    child: const AnkiGptApp(),
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

class AnkiGptApp extends ConsumerWidget {
  const AnkiGptApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Call shared preferences to initialize it.
    ref.read(sharedPreferencesAccesserProvider);

    return MaterialApp(
      title: 'AnkiGPT',
      theme: ankigptTheme,
      home: const HomePage2(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/session/') ?? false) {
          final sessionId = settings.name!.split('/').last;
          return MaterialPageRoute(
            builder: (context) => SessionPage(sessionId: sessionId),
          );
        }

        return null;
      },
      routes: {
        '/imprint': (context) => const ImprintPage(),
        '/account': (context) => const AccountPage(),
        '/sucessful-plus-payment': (context) =>
            const HomePage(hasSuccessfulPlusPayment: true),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.hasSuccessfulPlusPayment = false,
  });

  final bool hasSuccessfulPlusPayment;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (widget.hasSuccessfulPlusPayment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => const SuccessfulPlusPaymentDialog(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomePageAppBar(),
      bottomNavigationBar: Footer(),
      body: _Body(),
    );
  }
}

class SuccessfulPlusPaymentDialog extends StatefulWidget {
  const SuccessfulPlusPaymentDialog({super.key});

  @override
  State<SuccessfulPlusPaymentDialog> createState() =>
      _SuccessfulPlusPaymentDialogState();
}

class _SuccessfulPlusPaymentDialogState
    extends State<SuccessfulPlusPaymentDialog> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 6),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/diamond.svg',
                height: 160,
              ),
              Text(
                'Payment successful <3',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              const Text(
                'Thank you for your support!\n\nYou can now generate cards by just uploading a PDF file and generate up to 300 cards at once.\n\nAdditionally, you have now access to the premium support where you get answers to your questions within a few hours.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          ConfettiWidget(
            confettiController: confettiController,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      controller: ref.watch(scrollControllerProvider),
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
          showPlusDialog(context);
          return;
        }

        ref.read(generateNotifierProvider.notifier).pickFile();
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 275),
        child: Material(
          key: ValueKey(hasPlus),
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
                  showPlusDialog(context);
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

void showPlusDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const PlusDialog(),
    routeSettings: const RouteSettings(name: '/plus'),
  );
}

class PlusDialog extends ConsumerWidget {
  const PlusDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("AnkiGPT Plus"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: min(MediaQuery.of(context).size.height * 2, 300),
            child: const TutorialVideoPlayer(
              aspectRatio: 16 / 12,
              videoUrl:
                  'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fpdf-upload-tutorial.mp4?alt=media&token=a67cd7c1-ff89-41e8-a1f0-9daebe1caaed',
            ),
          ),
          const SizedBox(height: 16),
          const Text('''Advantages:
* Upload PDF files and automatically generate flashcards
* No character limit for the input text
* Generate 50, 100, 150 200 or 250 cards at once
* Premium support

Lifetime: €9.99 (no subscription)'''),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        const _BuyButton(),
      ],
    );
  }
}

class _BuyButton extends ConsumerStatefulWidget {
  const _BuyButton();

  @override
  ConsumerState<_BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends ConsumerState<_BuyButton> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final isSignedIn = ref.read(isSignedInProvider);
    if (isSignedIn) {
      // Generating URL in the background
      unawaited(ref.read(stripeCheckoutProvider.notifier).generateUrl());
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAccount = ref.watch(hasAccountProvider).value;
    return Stack(
      children: [
        Opacity(
          opacity: isLoading ? 0 : 1,
          child: IgnorePointer(
            ignoring: isLoading,
            child: TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                try {
                  // Analytics
                  unawaited(ref.read(clickedBuyProvider.future));

                  if (hasAccount == true) {
                    await ref.read(stripeCheckoutProvider.notifier).open();
                  } else {
                    ref.read(wantsToBuyProvider.notifier).toggle();
                    Navigator.pushNamed(context, '/account');
                  }
                } on Exception catch (e) {
                  context.showTextSnackBar('Error while buying Plus: $e');
                  Navigator.pop(context);
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text('BUY'),
            ),
          ),
        ),
        Opacity(
          opacity: isLoading ? 1 : 0,
          child: IgnorePointer(
            ignoring: !isLoading,
            child: const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}

class _ErrorCard extends ConsumerWidget {
  const _ErrorCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnkiGptCard(
      color: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.error,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Error!',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      text,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(generateNotifierProvider.notifier).submit();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: const Text('RETRY'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () =>
                        launchUrl(Uri.parse('https://ankigpt.wtf/support')),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: const Text('CONTACT SUPPORT'),
                  ),
                ],
              ),
            ],
          ),
        ],
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
              error: (_, __, language) => _Subtitle(
                language: language,
              ),
              success: (_, __, language) => _Subtitle(
                language: language,
              ),
              loading: (_, language, __) => _Subtitle(
                language: language,
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            state.maybeWhen(
              loading: (sessionId, language, isUploadingFile) => _ResultList(
                isUploadingFile: isUploadingFile,
                sessionId: sessionId,
              ),
              error: (error, sessionId, language) => Column(
                children: [
                  _ErrorCard(text: error),
                  const SizedBox(height: 12),
                  _ResultList(
                    sessionId: sessionId,
                    isUploadingFile: false,
                  )
                ],
              ),
              success: (sessionId, url, language) => _ResultList(
                sessionId: sessionId,
                isUploadingFile: false,
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

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();

  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  late bool isSearching;

  @override
  void initState() {
    super.initState();
    isSearching = ref.read(searchTextFieldControllerProvider).text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(generateNotifierProvider);
    if (state is GenerationStateError) {
      return const SizedBox.shrink();
    }

    return AnkiGptCard(
      color: Colors.grey,
      padding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ref.read(searchTextFieldControllerProvider),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).debounce(query);

                setState(() {
                  isSearching = query.isNotEmpty;
                });
              },
              decoration: const InputDecoration(
                hintText:
                    "Search to ensure AI hasn't overlooked key topics in your flashcards",
                border: InputBorder.none,
              ),
              onEditingComplete: () =>
                  ref.read(searchQueryProvider.notifier).fire(),
            ),
          ),
          const SizedBox(width: 12),
          AnimatedSwap(
            duration: const Duration(milliseconds: 300),
            child: isSearching
                ? IconButton(
                    key: const ValueKey(true),
                    tooltip: 'Clear',
                    onPressed: () =>
                        ref.read(searchQueryProvider.notifier).clear(),
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    key: const ValueKey(false),
                    onPressed: null,
                    icon: const Icon(Icons.search),
                    disabledColor: Theme.of(context).iconTheme.color,
                  ),
          ),
        ],
      ),
    );
  }
}

class _ResultList extends ConsumerWidget {
  const _ResultList({
    Key? key,
    required this.sessionId,
    required this.isUploadingFile,
  }) : super(key: key);

  final SessionId? sessionId;
  final bool isUploadingFile;

  void showDeleteSnackBar(
    BuildContext context,
    WidgetRef ref,
    CardId cardId,
  ) {
    context.hideSnackBar();
    context.showTextSnackBar(
      'Card deleted.',
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          ref
              .read(deleteCardControllerProvider.notifier)
              .undo(sessionId: sessionId!);
          context.hideSnackBar();
          context.showTextSnackBar('Card restored.');
        },
      ),
    );
  }

  void deleteCard(BuildContext context, WidgetRef ref, CardId cardId) {
    ref.read(deleteCardControllerProvider.notifier).delete(
          cardId: cardId,
          sessionId: sessionId!,
        );
    showDeleteSnackBar(context, ref, cardId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCardsCount = ref.watch(totalCardsCountProvider);
    if (totalCardsCount == 0) {
      return _LoadingCards(
        isUploadFile: isUploadingFile,
      );
    }

    final cards = ref.watch(cardsListControllerProvider).cards;

    return Column(
      children: [
        const _WarningCard(),
        const _SearchBar(),
        const SizedBox(height: 12),
        SelectionArea(
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
                  if (cards.isEmpty) const _EmptySearch(),
                  for (final card in cards)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ResultCard(
                        key: ValueKey(card.id),
                        card: card,
                        sessionId: sessionId!,
                        onDeleted: (cardId) {
                          // We need to make the delete call at this position in the widget tree because a call in the
                          // card would lead to an error when the presses the undo button.
                          deleteCard(context, ref, cardId);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const PaginationControl(),
      ],
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 28),
      child: SelectionContainer.disabled(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/empty-folder.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
              height: 150,
            ),
            const SizedBox(height: 16),
            Text(
              'Important flashcards are missing?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.feedback),
              onPressed: () =>
                  launchUrl(Uri.parse('https://ankigpt.wtf/support')),
              label: const Text('Send feedback'),
            ),
          ],
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
    required this.onDeleted,
  }) : super(key: key);

  final AnkiCard card;
  final SessionId sessionId;
  final ValueChanged<CardId> onDeleted;

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
          padding: const EdgeInsets.fromLTRB(0, 6, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CardQuestion(
                    question: widget.card.question,
                    cardId: widget.card.id,
                    sessionId: widget.sessionId,
                  ),
                  _Controls(
                    isHovering: hovering,
                    cardId: widget.card.id,
                    randomNumber: randomNumber,
                    sessionId: widget.sessionId,
                    onDeleted: widget.onDeleted,
                  )
                ],
              ),
              const SizedBox(height: 4),
              _CardAnswer(
                answer: widget.card.answer,
                cardId: widget.card.id,
                sessionId: widget.sessionId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardTextField extends StatefulWidget {
  const _CardTextField({
    required this.text,
    required this.onChanged,
    required this.style,
  });

  final ValueChanged<String> onChanged;
  final String text;
  final TextStyle style;

  @override
  State<_CardTextField> createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<_CardTextField> {
  bool hovering = false;
  int randomNumber = 0;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: hovering ? Colors.grey : Colors.transparent,
        child: TextField(
          controller: controller,
          maxLines: null,
          onChanged: widget.onChanged,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: widget.style,
        ),
      ),
    );
  }
}

class _CardAnswer extends ConsumerWidget {
  const _CardAnswer({
    required this.cardId,
    required this.answer,
    required this.sessionId,
  });

  final CardId cardId;
  final String answer;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardTextField(
      onChanged: (text) => ref.read(editAnswerProvider.notifier).debounce(
            cardId: cardId,
            answer: text,
            sessionId: sessionId,
          ),
      text: answer,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 14,
      ),
    );
  }
}

class _CardQuestion extends ConsumerWidget {
  const _CardQuestion({
    required this.cardId,
    required this.question,
    required this.sessionId,
  });

  final CardId cardId;
  final String question;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: _CardTextField(
        text: question,
        onChanged: (text) => ref.read(editQuestionProvider.notifier).debounce(
              cardId: cardId,
              question: text,
              sessionId: sessionId,
            ),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
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
    required this.onDeleted,
  });

  final bool isHovering;
  final CardId cardId;
  final SessionId sessionId;
  final int randomNumber;
  final ValueChanged<CardId> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(cardFeedbackStatusControllerProvider)[cardId] ??
        CardFeedbackStatus.notReviewed;
    final hasLiked = status == CardFeedbackStatus.liked;
    final hasDisliked = status == CardFeedbackStatus.disliked;
    return IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
            size: 15,
          ),
      child: Row(
        children: [
          _EditButton(
            isVisibile: isHovering,
            randomNumber: randomNumber,
          ),
          _DeleteButton(
            cardId: cardId,
            isVisibile: isHovering,
            randomNumber: randomNumber,
            onDeleted: onDeleted,
          ),
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
                        onPressed: () {
                          ref
                              .read(
                                  cardFeedbackStatusControllerProvider.notifier)
                              .setStatus(cardId, CardFeedbackStatus.disliked);
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
                        onPressed: () {
                          ref
                              .read(
                                  cardFeedbackStatusControllerProvider.notifier)
                              .setStatus(cardId, CardFeedbackStatus.liked);
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
            ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    required this.isVisibile,
    required this.randomNumber,
  });

  final bool isVisibile;
  final int randomNumber;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Opacity(
        key: ValueKey('$randomNumber + $isVisibile'),
        opacity: isVisibile ? 1 : 0,
        child: IgnorePointer(
          ignoring: !isVisibile,
          child: IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tutorial: Edit card'),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 400,
                        child: TutorialVideoPlayer(
                          aspectRatio: 16 / 9,
                          videoUrl:
                              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fedit-card-tutorial.mp4?alt=media&token=4473f746-93b9-4fb3-a5c1-4489854f1779',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                          'Just click on the card to edit it. Auto-save is enabled.'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.cardId,
    required this.isVisibile,
    required this.randomNumber,
    required this.onDeleted,
  });

  final CardId cardId;
  final bool isVisibile;
  final int randomNumber;
  final ValueChanged<CardId> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Opacity(
        key: ValueKey('$isVisibile + $randomNumber'),
        opacity: isVisibile ? 1 : 0,
        child: IgnorePointer(
          ignoring: !isVisibile,
          child: IconButton(
            tooltip: 'Delete',
            onPressed: () => onDeleted(cardId),
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
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
      onPressed: () {
        ref
            .read(cardFeedbackStatusControllerProvider.notifier)
            .setStatus(cardId, CardFeedbackStatus.notReviewed);
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
      onPressed: () {
        ref
            .read(cardFeedbackStatusControllerProvider.notifier)
            .setStatus(cardId, CardFeedbackStatus.notReviewed);
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
              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fankigpt.mp4?alt=media&token=4ffb0db0-b24d-4bc5-87bc-f339725105d6',
        ),
      ),
    );
  }
}

class _Subtitle extends ConsumerWidget {
  const _Subtitle({
    required this.language,
  });

  final Language? language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final isSearching = query.isNotEmpty;

    int cardsCount = 0;
    if (isSearching) {
      final view = ref.watch(cardsListControllerProvider);
      cardsCount = view.cards.length;
    } else {
      cardsCount = ref.watch(totalCardsCountProvider);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        'Detected language: ${language == null ? '...' : language!.getDisplayName()}, $cardsCount cards',
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
            'Copy the text of 2 - 10 slides of the lecture and paste it here. Supports all langauges (e.g. English, French, Spanish, German, etc.).',
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
  hunderFifty,
  twoHundred,
  twoHundredsFifty;

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
      case CardGenrationSize.hunderFifty:
        return 150;
      case CardGenrationSize.twoHundred:
        return 200;
      case CardGenrationSize.twoHundredsFifty:
        return 250;
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
        return '~ 1 - 2 min';
      case CardGenrationSize.fifty:
        return '~ 3 min';
      case CardGenrationSize.hundred:
        return '~ 5 min';
      case CardGenrationSize.hunderFifty:
        return '~ 5 min';
      case CardGenrationSize.twoHundred:
        return '~ 5 - 10 min';
      case CardGenrationSize.twoHundredsFifty:
        return '~ 5 - 10 min';
    }
  }

  bool isPlus() {
    switch (this) {
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hunderFifty:
      case CardGenrationSize.twoHundred:
      case CardGenrationSize.twoHundredsFifty:
        return true;
      default:
        return false;
    }
  }

  bool isAvailableForFiles() {
    switch (this) {
      case CardGenrationSize.twenty:
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hunderFifty:
      case CardGenrationSize.twoHundred:
      case CardGenrationSize.twoHundredsFifty:
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
    final hasPickedFile = ref.watch(pickedFileProvider) != null;

    final avaliableSizes = CardGenrationSize.values
        .where((c) => hasPickedFile ? c.isAvailableForFiles() : true)
        .toList();

    return SizedBox(
      width: 154,
      child: DropdownButtonFormField<CardGenrationSize>(
        value: ref.watch(generationSizeProvider),
        items: [
          ...avaliableSizes.map(
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
              showPlusDialog(context);
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
                    await ref.read(generateNotifierProvider.notifier).submit();
                  } catch (e) {
                    if (e is PlusMembershipRequiredException) {
                      showPlusDialog(context);
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
          'Please add more text (min. 400 characters). If the text is too short, GPT cannot generate the flashcards.',
    );
  }
}

class TooLongInputDialog extends StatelessWidget {
  const TooLongInputDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstrainedBox(
      maxWidth: 500,
      child: AlertDialog(
        title: const Text('Too long!'),
        content: const Text(
            'Your text is too long. Free users have a limt of 5,000 characters.\n\nBuy AnkiGPT Plus for €9.99 (one-time purchase) to remove this limit.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          const _BuyButton(),
        ],
      ),
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
            loading: (_, __, ___) => 'Still generating... Please wait.',
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
                    showDialog(
                      context: context,
                      builder: (context) => const _ExportToAnkiDialog(),
                      routeSettings:
                          const RouteSettings(name: '/export-to-anki'),
                    );
                  }
                : null,
            icon: const Icon(Icons.download),
          ),
        ),
      ),
    );
  }
}

class _ExportToAnkiDialog extends StatelessWidget {
  const _ExportToAnkiDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tutorial: How import a .csv file into Anki'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: min(MediaQuery.of(context).size.height * 2, 300),
              child: const TutorialVideoPlayer(
                aspectRatio: 4 / 2.9,
                videoUrl:
                    'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fanki-import-tutorial.mp4?alt=media&token=87f434d0-8318-47d0-b0e1-4c86753b9eb3',
              ),
            ),
            const SizedBox(height: 18),
            const Text('''1. Open Anki and click on "Import" in the menu bar.
2. Select the .csv file you just downloaded.
3. Select "Comma" as Field Separator.
4. Make sure to select the right deck.
5. Click on "Import".'''),
            const SizedBox(height: 12),
            const _WarningAfterDownload(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
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

class _WarningAfterDownload extends ConsumerWidget {
  const _WarningAfterDownload();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const color = Colors.orangeAccent;
    return SizedBox(
      width: min(MediaQuery.of(context).size.height * 2, 400),
      child: const AnkiGptCard(
        color: color,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.warning, color: color, size: 30),
            SizedBox(width: 12),
            Flexible(
              child: Text(
                "AnkiGPT is your co-pilot, not the captain! Remember, even AI stumbles sometimes, so be sure to double-check those cards!",
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WarningCard extends ConsumerWidget {
  const _WarningCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShow = ref.watch(showWarningCardProvider);
    const color = Colors.orangeAccent;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: shouldShow
          ? Padding(
              key: ValueKey(shouldShow),
              padding: const EdgeInsets.only(bottom: 12),
              child: AnkiGptCard(
                color: color,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: color, size: 40),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AnkiGPT is your co-pilot, not the captain! Remember, even AI stumbles sometimes, so be sure to double-check those cards. Don't forget, nothing beats the magic of your own creative touch in the flashcard mix!",
                            style: TextStyle(
                              color: color,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hide this warning',
                      onPressed: () =>
                          ref.read(showWarningCardProvider.notifier).hide(),
                      icon: const Icon(Icons.close, color: color),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox.shrink(
              key: ValueKey(shouldShow),
            ),
    );
  }
}
