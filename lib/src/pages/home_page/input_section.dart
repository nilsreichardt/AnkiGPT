import 'dart:math';

import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/plus_badge.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
                const Controls(),
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
        top: min(35, MediaQuery.of(context).size.width * 0.1),
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
    final controller = ref.watch(inputTextFieldControllerProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: hasPickedFile
          ? const SizedBox()
          : InputTextField(
              controller: controller,
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
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 275),
        child: AnkiGptCard(
          key: ValueKey(hasPlus),
          onPressed: () {
            final hasPlus = ref.read(hasPlusProvider);
            if (!hasPlus) {
              showPlusDialog(context);
              return;
            }

            ref.read(generateNotifierProvider.notifier).pickFile();
          },
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
    return AnkiGptCard(
      onPressed: isLoading
          ? null
          : () {
              final hasPlus = ref.read(hasPlusProvider);
              if (!hasPlus) {
                showPlusDialog(context);
                return;
              }

              ref.read(generateNotifierProvider.notifier).pickFile();
            },
      borderRadius: borderRadius,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: SizedBox(
        width: double.infinity,
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
    );
  }
}
