import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/deck_page/result_section.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/deck_page_scroll_controller_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class DeckPage extends ConsumerStatefulWidget {
  const DeckPage({
    super.key,
    required this.sessionId,
  });

  final SessionId? sessionId;

  @override
  ConsumerState<DeckPage> createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<DeckPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final logger = ref.read(loggerProvider);

      final sessionId = widget.sessionId;
      if (sessionId != null) {
        ref
            .read(watchProvider(sessionId).notifier)
            .watch(sessionId: widget.sessionId!);
        logger.t('Watch session: $sessionId');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = widget.sessionId ?? "does-not-exist";
    // Keep provider alive.
    ref.watch(watchProvider(sessionId));

    return ProviderScope(
      overrides: [
        sessionIdProvider.overrideWithValue(widget.sessionId),
      ],
      child: SelectionArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const MaxWidthConstrainedBox(
              maxWidth: 900,
              child: Row(
                children: [
                  BackButton(),
                  Spacer(),
                  _ExportToAnkiButton(),
                ],
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              controller: ref.watch(deckPageScrollControllerProvider),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                      maxWidth: 900,
                    ),
                    child: const _Body(),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
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
      label: const Text(
        'Export to Anki',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
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
      title: const Text('Tutorial: How to import a .csv file into Anki'),
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

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: ResultSection(),
    );
  }
}
