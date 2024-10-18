import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/cancel_text_button.dart';
import 'package:ankigpt/src/pages/widgets/plus_badge.dart';
import 'package:ankigpt/src/providers/current_usage_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/options_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OptionsDialog extends StatelessWidget {
  const OptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Options'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 350,
          maxWidth: 350,
        ),
        child: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ModelOption(),
            ],
          ),
        ),
      ),
      actions: [
        const CancelTextButton(),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final Widget title;
  final Widget subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(fontSize: 18),
          child: title,
        ),
        const SizedBox(height: 2),
        DefaultTextStyle(
          style: TextStyle(
            color: Colors.grey[600]!,
            fontSize: 12,
          ),
          child: subtitle,
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _ModelOption extends StatelessWidget {
  const _ModelOption();

  @override
  Widget build(BuildContext context) {
    return const _Option(
      title: Text('Model'),
      subtitle: Text(
          'Specify the LLM model that will be used to generate the flashcards. A better model will generate better flashcards, but will take longer to generate.'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ModelDropdown(),
          _Gpt4Usage(),
        ],
      ),
    );
  }
}

class ModelDropdown extends ConsumerWidget {
  const ModelDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black54,
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
    return SizedBox(
      width: double.infinity,
      child: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.light,
        ),
        child: DropdownButtonFormField<Model>(
          dropdownColor: Colors.white,
          value: ref.watch(optionsControllerProvider.select((v) => v.model)),
          decoration: const InputDecoration(
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
          items: [
            ...[Model.gpt4o_mini, Model.gpt4o].map(
              (c) => DropdownMenuItem(
                value: c,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.getUiText(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    if (!hasPlus && c.isPlus()) ...[
                      const SizedBox(width: 12),
                      const SizedBox(
                        width: 38,
                        child: PlusBadge(withText: false),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
          onChanged: (v) {
            if (v != null) {
              if (!hasPlus && v.isPlus()) {
                showPlusDialog(context);
              }

              ref.read(optionsControllerProvider.notifier).setModel(v);
            }
          },
        ),
      ),
    );
  }
}

class _Gpt4Usage extends ConsumerWidget {
  const _Gpt4Usage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    if (!hasPlus) return const SizedBox();

    final gpt4Usage = ref.watch(currentGpt4UsageProvider);
    final selectedModel =
        ref.watch(optionsControllerProvider.select((v) => v.model));
    if (selectedModel != Model.gpt4o) return const SizedBox();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selectedModel == Model.gpt4o
          ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'You have used $gpt4Usage of your $plusGpt4UsageLimitPerMonth monthly GPT-4o limit.',
                style: TextStyle(
                  color: Colors.grey[600]!,
                  fontSize: 12,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
