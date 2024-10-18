import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/deck_page/error_card.dart';
import 'package:ankigpt/src/pages/home_page/options_dialog.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/options_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/total_cards_counter_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

class SizeRow extends StatelessWidget {
  const SizeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (final size in CardGenrationSize.values) _Size(size: size),
        ],
      ),
    );
  }
}

class _Size extends ConsumerWidget {
  const _Size({
    required this.size,
  });

  final CardGenrationSize size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(16);
    final options = ref.watch(optionsControllerProvider);
    final hasPlus = ref.watch(hasPlusProvider);
    final isSelected = options.size == size;
    return Tooltip(
      message: 'Generate ${size.getUiText()} flashcards',
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          if (!hasPlus && size.isPlus()) {
            showModal(
              context: context,
              builder: (context) => const PlusDialog(),
              routeSettings: const RouteSettings(name: '/plus'),
            );
            return;
          } else {
            ref.read(optionsControllerProvider.notifier).setSize(size);
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                key: ValueKey(isSelected),
                borderRadius: borderRadius,
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.2),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Text(
                    size.getUiText(),
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
              if (!hasPlus && size.isPlus()) const _PlusIcon(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlusIcon extends StatelessWidget {
  const _PlusIcon();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -8,
      top: -8,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(4),
          child: Icon(
            Remix.lock_2_fill,
            color: Colors.black,
            size: 16,
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _OptionsButton extends ConsumerWidget {
  const _OptionsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep the provider alive
    ref.watch(optionsControllerProvider);

    return SizedBox(
      child: AnkiGptElevatedButton.icon(
        tooltip: 'Edit options (e.g. number of cards, model)',
        icon: const Icon(Icons.tune),
        label: const Text('Options'),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.4,
        ),
        color: Colors.transparent,
        center: context.isMobile,
        onPressed: () {
          showModal(
            context: context,
            builder: (context) => const OptionsDialog(),
            routeSettings: const RouteSettings(name: '/options'),
          );
        },
      ),
    );
  }
}

class GenerateButton extends ConsumerWidget {
  const GenerateButton();

  Future<void> generate(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(generateNotifierProvider.notifier).submit();
    } catch (e) {
      if (!context.mounted) return;

      if (e is PlusMembershipRequiredException) {
        showPlusDialog(context);
        return;
      }

      if (e is TooShortInputException) {
        showModal(
          context: context,
          builder: (context) => const _TooLessInputDialog(),
        );
        return;
      }

      if (e is TooLongInputException) {
        showInputTooLong(context);
        return;
      }

      if (e is FreeLimitExceededException) {
        showPlusDialog(
          context,
          top: _FreeLimitExceededCard(
            currentDeckSize: e.currentDeckSize,
            remainingCardsForCurrentMonth: e.remainingFreeLimit,
          ),
        );
        return;
      }

      if (e is Gpt4LimitExceededException) {
        showPlusDialog(
          context,
          top: _Gpt4LimitExceededCard(
            currentDeckSize: e.currentDeckSize,
            remainingCardsForCurrentMonth: e.remainingGpt4Limit,
          ),
        );
        return;
      }

      context.showTextSnackBar('$e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGenerating =
        (ref.watch(generateNotifierProvider) is GenerationStateLoading);

    final options = ref.watch(optionsControllerProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        child: AnkiGptElevatedButton.icon(
          key: ValueKey(isGenerating),
          tooltip: isGenerating
              ? 'Generating...'
              : 'Generate ${options.size.getUiText()} flashcards (${options.model.getUiText()})',
          icon: isGenerating ? null : const Icon(Remix.bard_fill),
          borderRadius: BorderRadius.circular(16),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: isGenerating
                ? const _GenerateButtonLoadingIndicator()
                : const Text('Generate flashcards'),
          ),
          center: true,
          onPressed: isGenerating ? null : () => generate(context, ref),
        ),
      ),
    );
  }
}

class GenerationErrorCard extends ConsumerWidget {
  const GenerationErrorCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ErrorCard(
        text: message,
        onRetry: () => ref.read(generateNotifierProvider.notifier).submit(),
      ),
    );
  }
}

class _FreeLimitExceededCard extends StatelessWidget {
  const _FreeLimitExceededCard({
    required this.currentDeckSize,
    required this.remainingCardsForCurrentMonth,
  });

  final int currentDeckSize;
  final int remainingCardsForCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return _LimitExceededCard(text: '''**Limit reached!**

As a free user, you can create a maximum of $freeUsageLimitPerMonth cards per month. You have $remainingCardsForCurrentMonth remaining, but you attempted to generate $currentDeckSize cards. To produce more cards, consider upgrading to Plus.''');
  }
}

class _Gpt4LimitExceededCard extends StatelessWidget {
  const _Gpt4LimitExceededCard({
    required this.currentDeckSize,
    required this.remainingCardsForCurrentMonth,
  });

  final int currentDeckSize;
  final int remainingCardsForCurrentMonth;

  @override
  Widget build(BuildContext context) {
    return _LimitExceededCard(text: '''**Limit reached!**

You can create a maximum of $plusGpt4UsageLimitPerMonth cards with GPT-4 per month. You have $remainingCardsForCurrentMonth remaining, but you attempted to generate $currentDeckSize cards.''');
  }
}

class _LimitExceededCard extends StatelessWidget {
  const _LimitExceededCard({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MaxWidthConstrainedBox(
        maxWidth: 450,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange[100]!.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: MarkdownBody(
            data: text,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenerateButtonLoadingIndicator extends StatelessWidget {
  const _GenerateButtonLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}

class _ExportToAnkiButton extends ConsumerWidget {
  const _ExportToAnkiButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider) ?? 'does-not-exist';
    final view = ref.watch(watchProvider(sessionId));
    return AnkiGptElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: const Text('Export to Anki'),
      onPressed: view.isDownloadAvailable
          ? () {
              launchUrl(Uri.parse(view.downloadUrl!));
              showModal(
                context: context,
                builder: (context) => const _ExportToAnkiDialog(),
                routeSettings: const RouteSettings(name: '/export-to-anki'),
              );
            }
          : null,
      tooltip: view.downloadButtonTooltip,
      center: context.isMobile,
      isEnabled: view.isDownloadAvailable,
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
            const ListTile(
              title:
                  Text('1. Open Anki and click on "Import" in the menu bar.'),
            ),
            const ListTile(
              title: Text('2. Select the .csv file you just downloaded.'),
            ),
            const ListTile(
              title: Text('3. Select "Comma" as Field Separator.'),
            ),
            const ListTile(
              title: Text('4. Make sure to select the right deck.'),
            ),
            const ListTile(
              title: Text('5. Click on "Import".'),
            ),
            const SizedBox(height: 12),
            const _WarningAfterDownload(),
            const SizedBox(height: 12),
            const _ContactSupportNote(),
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

class _ContactSupportNote extends StatelessWidget {
  const _ContactSupportNote();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: MarkdownBody(
        data:
            'If you have any questions, please reach out to the [AnkiGPT Support](https://ankigpt.help/support).',
        styleSheet: MarkdownStyleSheet(
          textAlign: WrapAlignment.center,
          p: const TextStyle(
            fontSize: 16,
          ),
        ),
        onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
      ),
    );
  }
}

class _WarningAfterDownload extends ConsumerWidget {
  const _WarningAfterDownload();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const color = Colors.deepOrange;
    return SizedBox(
      width: min(MediaQuery.of(context).size.height * 2, 400),
      child: const AnkiGptCard(
        color: Color(0xFFFFDFC1),
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

class _LoadingButton extends ConsumerWidget {
  const _LoadingButton();

  bool isLoading({
    required bool isViewLoaidng,
    required bool isSearchLoading,
    required int totalCards,
  }) {
    if (totalCards == 0) {
      return false;
    }

    return isViewLoaidng || isSearchLoading;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider) ?? 'does-not-exist';
    final view = ref.watch(watchProvider(sessionId));
    final isSearchLoading = ref.watch(isSearchLoadingProvider);
    final totalCards = ref.watch(totalCardsCountProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isLoading(
        isViewLoaidng: view.isLoading,
        isSearchLoading: isSearchLoading,
        totalCards: totalCards,
      )
          ? const Padding(
              padding: EdgeInsets.only(right: 18),
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox(),
    );
  }
}

class _TooLessInputDialog extends StatelessWidget {
  const _TooLessInputDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input too short!'),
      content: const Text(
          'Please add more text (min. 400 characters). If the text is too short, GPT cannot generate the flashcards.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
