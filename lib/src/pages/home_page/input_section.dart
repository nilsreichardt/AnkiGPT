import 'dart:math';

import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/traction_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class InputSection extends ConsumerWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScrollViewProvider).inputSectionKey,
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
                const _TabView(),
                const _EnterPdfPassword(),
                const Controls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabView extends ConsumerStatefulWidget {
  const _TabView();

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends ConsumerState<_TabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          dividerHeight: 0,
          splashBorderRadius: BorderRadius.circular(24),
          tabs: const [
            Tab(text: 'Upload File'),
            Tab(text: 'Input Text'),
          ],
        ),
        SizedBox(
          height: 230, // Adjust height as needed
          child: TabBarView(
            controller: _tabController,
            children: const [
              _FileButton(),
              _InputField(),
            ],
          ),
        ),
      ],
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
        bottom: 52,
      ),
      child: const Column(
        children: [
          AutoSizeText(
            'Turn lecture slides\ninto Anki flashcards.',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          SizedBox(height: 6),
          _Traction(),
        ],
      ),
    );
  }
}

class _Traction extends ConsumerWidget {
  const _Traction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getTractionStreamProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: Text(
        'Generated ${value.map(data: (d) => d.value, error: (e) => 'XXX,XXX', loading: (_) => '000,000')} flashcards so far.',
        key: ValueKey(value),
        style: TextStyle(
          fontSize: 18,
          fontFeatures: const [FontFeature.tabularFigures()],
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        textAlign: TextAlign.center,
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
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 275),
        child: AnkiGptCard(
          onPressed: () =>
              ref.read(generateNotifierProvider.notifier).pickFile(),
          borderRadius: borderRadius,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
          child: const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.upload_file),
                  SizedBox(height: 13),
                  Text('Upload PDF file'),
                  Text(
                    'Or drag and drop it here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                  ),
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
          : () => ref.read(generateNotifierProvider.notifier).pickFile(),
      borderRadius: borderRadius,
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 68, 12, 40),
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

class _EnterPdfPassword extends ConsumerWidget {
  const _EnterPdfPassword();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateNotifierProvider);
    final isPasswordRequired = state is GenerationStatePasswordRequired;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: isPasswordRequired
          ? Padding(
              padding: const EdgeInsets.only(top: 16),
              child: AnkiGptCard(
                color: Colors.orange.withValues(alpha: 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.key),
                        SizedBox(width: 8),
                        Text(
                          'Enter PDF password',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your PDF file is encrypted. Enter the password to decrypt it. The password will not be stored.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onChanged: (password) {
                        ref
                            .read(generateNotifierProvider.notifier)
                            .setPassword(password);
                      },
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
