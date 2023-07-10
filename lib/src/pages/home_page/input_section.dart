import 'dart:math';

import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
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
              const _UploadFileButton(),
              const _Controls(),
            ],
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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFCECECE),
        width: 2,
      ),
    );
    return TextField(
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

class _Controls extends StatelessWidget {
  const _Controls();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          _ExportToAnkiButton(),
          Expanded(child: SizedBox()),
          _OptionsButton(),
          SizedBox(width: 12),
          _GenerateButton(),
        ],
      ),
    );
  }
}

class _OptionsButton extends StatelessWidget {
  const _OptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      icon: const Icon(Icons.tune),
      label: const Text('Options'),
      border: Border.all(
        color: Colors.grey[400]!,
        width: 1.4,
      ),
      color: Colors.transparent,
      onPressed: () {
        print('Generate');
      },
    );
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      icon: const Icon(Icons.play_arrow),
      label: const Text('Generate'),
      onPressed: () {
        print('Generate');
      },
    );
  }
}

class _ExportToAnkiButton extends StatelessWidget {
  const _ExportToAnkiButton();

  @override
  Widget build(BuildContext context) {
    return AnkiGptElevatedButton.icon(
      icon: const Icon(Icons.download),
      label: const Text('Export to Anki'),
      onPressed: () {},
      isEnabled: false,
    );
  }
}
