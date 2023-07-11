import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/plus_badge.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class InputSection extends ConsumerWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScollViewProvider).inputSectionKey,
      maxWidth: 700,
      child: AnimationLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 450),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 20,
                child: FadeInAnimation(child: widget),
              ),
              delay: const Duration(milliseconds: 250),
              children: [
                const _Headline(),
                const _InputField(),
                const _FileButton(),
                const _Controls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: min(65, MediaQuery.of(context).size.width * 0.1),
        bottom: 38,
      ),
      child: const AutoSizeText(
        'Turn lecture slides\ninto flashcards.',
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          height: 1.1,
        ),
      ),
    );
  }
}

class _InputField extends ConsumerWidget {
  const _InputField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPickedFile = ref.watch(hasPickedFileProvider);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFCECECE),
        width: 2,
      ),
    );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: hasPickedFile
          ? const SizedBox()
          : TextField(
              controller: ref.watch(slideTextFieldControllerProvider),
              autofocus: true,
              decoration: InputDecoration(
                  focusedBorder: border,
                  enabledBorder: border,
                  filled: true,
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  hintText:
                      '''Copy the text of a few slides and paste it into this text field.
Supports all languages.''',
                  hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
              minLines: 6,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
    );
  }
}

class _FileButton extends ConsumerWidget {
  const _FileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPickedFile = ref.watch(hasPickedFileProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: Container(
        key: ValueKey(hasPickedFile),
        child: hasPickedFile
            ? const _PickedFileButton()
            : const _UploadFileButton(),
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
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
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
            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
            child: SizedBox(
              width: double.infinity,
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

class _Controls extends StatelessWidget {
  const _Controls();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: context.isMobile
          ? const _MobileControlsView()
          : const _DesktopControlsView(),
    );
  }
}

class _DesktopControlsView extends StatelessWidget {
  const _DesktopControlsView();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _ExportToAnkiButton(),
        Expanded(child: SizedBox()),
        _OptionsButton(),
        SizedBox(width: 12),
        _GenerateButton(),
      ],
    );
  }
}

class _MobileControlsView extends StatelessWidget {
  const _MobileControlsView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ExportToAnkiButton(),
        SizedBox(height: 12),
        _OptionsButton(),
        SizedBox(height: 12),
        _GenerateButton(),
      ],
    );
  }
}

class _OptionsButton extends StatelessWidget {
  const _OptionsButton();

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      tooltip: 'Edit options (e.g. number of cards)',
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
          builder: (context) => const _OptionsDialog(),
          routeSettings: const RouteSettings(name: '/options'),
        );
      },
    );
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton();

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      tooltip: 'Generate flashcards',
      icon: const Icon(Icons.play_arrow),
      label: const Text('Generate'),
      center: context.isMobile,
      onPressed: () {
        showInputTooLong(context);
      },
    );
  }
}

class _ExportToAnkiButton extends ConsumerWidget {
  const _ExportToAnkiButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(generateNotifierProvider);
    final isFinished = state is GenerationStateSuccess;
    return AnkiGptElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: const Text('Export to Anki'),
      onPressed: isFinished
          ? () {
              final url = state.downloadUrl;
              if (url == null) {
                context.showTextSnackBar('Download failed.');
                return;
              }

              launchUrl(Uri.parse(url));
              showModal(
                context: context,
                builder: (context) => const _ExportToAnkiDialog(),
                routeSettings: const RouteSettings(name: '/export-to-anki'),
              );
            }
          : null,
      tooltip: state.maybeWhen(
        loading: (_, __, ___) => 'Still generating... Please wait.',
        success: (_, __, ___) => 'Download as .csv file to import it',
        orElse: () => '',
      ),
      center: context.isMobile,
      isEnabled: isFinished,
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

class _OptionsDialog extends StatelessWidget {
  const _OptionsDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Options'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 300,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Number of cards',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Specify the number of cards to generate.',
              style: TextStyle(
                color: Colors.grey[600]!,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            const NumberOfCardsDropdown(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class NumberOfCardsDropdown extends ConsumerWidget {
  const NumberOfCardsDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    final hasPickedFile = ref.watch(pickedFileProvider) != null;

    final avaliableSizes = CardGenrationSize.values
        .where((c) => hasPickedFile ? c.isAvailableForFiles() : true)
        .toList();

    return SizedBox(
      width: double.infinity,
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
