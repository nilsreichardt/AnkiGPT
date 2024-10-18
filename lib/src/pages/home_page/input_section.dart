import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher.dart';

class InputSection extends ConsumerWidget {
  const InputSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateNotifierProvider);
    final isPasswordRequired = state is GenerationStatePasswordRequired;
    return Material(
      key: ref.read(homePageScrollViewProvider).inputSectionKey,
      color: Colors.white12,
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: AnimationLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1300),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 20,
                child: FadeInAnimation(child: widget),
              ),
              delay: const Duration(milliseconds: 250),
              children: [
                const _TabView(),
                if (isPasswordRequired) const _EnterPdfPassword(),
                if (state is GenerationStateError)
                  GenerationErrorCard(message: state.message),
                const SizeRow(),
                const GenerateButton(),
                const _ExportToAnki(),
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
    const borderRadius = BorderRadius.all(Radius.circular(24));
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 275),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => ref.read(generateNotifierProvider.notifier).pickFile(),
          child: Material(
            color: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: BorderSide(
                color: Colors.white30,
                width: 3,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(
                      Remix.upload_cloud_2_line,
                      size: 48,
                    ),
                    const SizedBox(height: 13),
                    AnkiGptElevatedButton.icon(
                      icon: const Icon(Remix.file_add_line),
                      mainAxisSize: MainAxisSize.min,
                      label: const Text('Upload PDF file'),
                      onPressed: () => ref
                          .read(generateNotifierProvider.notifier)
                          .pickFile(),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Or drag and drop it here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
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
    return AnkiGptCard(
      onPressed: isLoading
          ? null
          : () => ref.read(generateNotifierProvider.notifier).pickFile(),
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
                color: Colors.orange.withOpacity(0.1),
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
                            .withOpacity(0.6),
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

class _ExportToAnki extends ConsumerWidget {
  const _ExportToAnki();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const fontSize = 16.0;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text.rich(
        TextSpan(
          text: 'After generating, you can export your flashcards to ',
          style: const TextStyle(
            color: Colors.white54,
            fontSize: fontSize,
          ),
          children: [
            TextSpan(
              text: 'Anki',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse('https://apps.ankiweb.net/'));
                },
            ),
          ],
        ),
      ),
    );
  }
}
