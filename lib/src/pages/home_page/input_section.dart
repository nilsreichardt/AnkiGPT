import 'dart:math';

import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputSection extends StatelessWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstrainedBox(
      maxWidth: 700,
      child: Column(
        children: [
          SizedBox(height: min(65, MediaQuery.of(context).size.width * 0.1)),
          const _Headline(),
          const SizedBox(height: 50),
          const _InputField(),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return const AutoSizeText(
      'Turn lecture slides\ninto flashcards.',
      textAlign: TextAlign.center,
      maxLines: 2,
      style: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        height: 1.1,
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
