import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/deck_page/error_card.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/cancel_text_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/grey_shimmer.dart';
import 'package:ankigpt/src/pages/widgets/text_or_circular_progess_indicator.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/share_controller_provider.dart';
import 'package:flutter/material.dart' hide Visibility;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareDialog extends ConsumerStatefulWidget {
  const ShareDialog({
    super.key,
    required this.sessionId,
  });

  final SessionId sessionId;

  @override
  ConsumerState<ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends ConsumerState<ShareDialog> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shareControllerProvider(widget.sessionId).notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    Visibility visibility = Visibility.private;
    return ProviderScope(
      overrides: [
        sessionIdProvider.overrideWithValue(widget.sessionId),
      ],
      child: SelectionArea(
        child: AlertDialog(
          title: const Text('Set visibility of deck'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 450,
              maxWidth: 450,
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CustomGptNote(),
                _VisibilityButtons(),
                _CopyLinkCard(),
                _ErrorCard(),
              ],
            ),
          ),
          actions: [
            const CancelTextButton(),
            _SaveButton(visibility: visibility),
          ],
        ),
      ),
    );
  }
}

class _CustomGptNote extends ConsumerWidget {
  const _CustomGptNote();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(shareControllerProvider(sessionId));
    final isGeneratedByCustomGpt = switch (state) {
      ShareStateGpt() => true,
      _ => false,
    };

    if (!isGeneratedByCustomGpt) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnkiGptCard(
        color: Colors.orange.withValues(alpha: 0.1),
        child: const Text(
          'This deck is generated with the a GPT using ChatGPT. These decks are always public and can not be made private.',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _VisibilityButtons extends ConsumerWidget {
  const _VisibilityButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(shareControllerProvider(sessionId));

    final isLoading = switch (state) {
      ShareStateLoading() => true,
      _ => false,
    };
    final currentVisibility = switch (state) {
      ShareStateSelected(visibility: final visibility) => visibility,
      ShareStateError(visibility: final visibility) => visibility,
      ShareStateUpdating(visibility: final visibility) => visibility,
      ShareStateLoaded(visibility: final visibility) => visibility,
      ShareStateGpt(visibility: final visibility) => visibility,
      ShareStateLoading() => null,
    };

    final isGeneratedByCustomGpt = switch (state) {
      ShareStateGpt() => true,
      _ => false,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final v in Visibility.values)
          GreyShimmer(
            enabled: isLoading,
            child: RadioListTile<Visibility>(
              shape: RoundedRectangleBorder(
                borderRadius: defaultAnkiGptBorderRadius,
              ),
              title: Text(switch (v) {
                Visibility.private => 'Private',
                Visibility.anyoneWithLink => 'Anyone with link',
              }),
              subtitle: Text(switch (v) {
                Visibility.private => 'Only you can see this deck.',
                Visibility.anyoneWithLink =>
                  'Anyone with the link can see this deck.',
              }),
              value: v,
              groupValue: currentVisibility,
              onChanged: isLoading || isGeneratedByCustomGpt
                  ? null
                  : (v) {
                      if (v == null) return;

                      ref
                          .read(shareControllerProvider(sessionId).notifier)
                          .setVisibility(v);
                    },
            ),
          ),
      ],
    );
  }
}

class _CopyLinkCard extends ConsumerWidget {
  const _CopyLinkCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(shareControllerProvider(sessionId));

    final url = switch (state) {
      ShareStateLoaded(url: final url) => url,
      ShareStateGpt(url: final url) => url,
      _ => null,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: IgnorePointer(
        key: ValueKey(url),
        ignoring: url == null,
        child: Opacity(
          opacity: url == null ? 0.5 : 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: AnkiGptCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: url == null
                        ? const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.lock),
                          )
                        : MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              '$url',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  _CopyIconButton(
                    url: url,
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

class _CopyIconButton extends StatelessWidget {
  const _CopyIconButton({
    required this.url,
  });

  final Uri? url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Copy link',
      icon: const Icon(Icons.content_copy),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: '$url'));
        if (!context.mounted) return;
        context.showTextSnackBar('Copied link to clipboard');
      },
    );
  }
}

class _ErrorCard extends ConsumerWidget {
  const _ErrorCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(shareControllerProvider(sessionId));

    final error = switch (state) {
      ShareStateError(error: final error) => error,
      _ => null,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: error == null
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ErrorCard(text: '$error'),
            ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({
    required this.visibility,
  });

  final Visibility visibility;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(shareControllerProvider(sessionId));
    final isEnabled = switch (state) {
      ShareStateSelected() => true,
      ShareStateError() => true,
      _ => false
    };
    final isUpdating =
        switch (state) { ShareStateUpdating() => true, _ => false };
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      onPressed: isEnabled
          ? () async {
              final controller =
                  ref.read(shareControllerProvider(sessionId).notifier);
              await controller.save();

              if (!context.mounted) return;
              context.showTextSnackBar(
                'Saved',
                duration: const Duration(seconds: 2),
              );
            }
          : null,
      child: TextOrCircularProgressIndicator(
        isUpdating: isUpdating,
        child: const Text('SAVE'),
      ),
    );
  }
}
