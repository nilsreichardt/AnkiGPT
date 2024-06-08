import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/import_from_gpt_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ImportFromGptPage extends StatelessWidget {
  const ImportFromGptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  const _Body(),
                  const SizedBox(height: 32),
                  const _Tutorial(),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> {
  late TextEditingController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> generate(BuildContext context) async {
    final text = _controller.text;

    if (text.isEmpty) {
      context.showTextSnackBar('Please enter some text.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final sessionId = await ref
          .read(importFromGptControllerProvider.notifier)
          .importFromGpt(text);
      if (!context.mounted) return;
      context.go('/deck/$sessionId');
    } catch (e) {
      if (!context.mounted) return;
      context.showTextSnackBar('Failed to import from GPT: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstrainedBox(
      maxWidth: 700,
      child: Column(
        children: [
          const AutoSizeText(
            'Convert ChatGPT text to .csv',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 32),
          InputTextField(
            controller: _controller,
            hintText:
                'Copy the text (using the copy button) from ChatGPT and paste it here. See the video below for instructions.',
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 120,
              child: AnkiGptElevatedButton.icon(
                key: ValueKey(isLoading),
                tooltip: isLoading ? 'Importing...' : '',
                icon: isLoading ? null : const Icon(Icons.add),
                label: isLoading
                    ? const _LoadingIndicator()
                    : const Text('Import'),
                center: context.isMobile,
                onPressed: isLoading ? null : () => generate(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 34, vertical: 2),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _Tutorial extends ConsumerWidget {
  const _Tutorial();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: MaxWidthConstrainedBox(
        child: TutorialVideoPlayer(
          aspectRatio: 16 / 9.6,
          videoUrl:
              'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fimport-tutorial.mp4?alt=media&token=a2ac635e-7f2d-477b-84fe-e18dd8922539',
        ),
      ),
    );
  }
}
