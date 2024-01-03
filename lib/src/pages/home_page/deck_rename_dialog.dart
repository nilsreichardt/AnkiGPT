import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/deck_page/error_card.dart';
import 'package:ankigpt/src/pages/widgets/cancel_text_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/text_or_circular_progess_indicator.dart';
import 'package:ankigpt/src/providers/rename_deck_controller.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showDeckRenameDialog({
  required BuildContext context,
  required String title,
  required SessionId sessionId,
}) {
  showModal(
    context: context,
    builder: (context) => DeckRenameDialog(
      title: title,
      sessionId: sessionId,
    ),
  );
}

class DeckRenameDialog extends StatelessWidget {
  const DeckRenameDialog({
    super.key,
    required this.title,
    required this.sessionId,
  });

  final String title;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sessionIdProvider.overrideWithValue(sessionId),
      ],
      child: AlertDialog(
        title: const Text('Rename Deck'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 325,
            maxWidth: 450,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TextField(title: title),
              const _Error(),
            ],
          ),
        ),
        actions: const [
          CancelTextButton(),
          _RenameButton(),
        ],
      ),
    );
  }
}

class _Error extends ConsumerWidget {
  const _Error();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(renameDeckControllerProvider(sessionId));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: state is RenameDeckError
          ? ErrorCard(
              text: state.message,
              onRetry: () async => await save(ref, context),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _TextField extends ConsumerStatefulWidget {
  const _TextField({
    required this.title,
  });

  final String title;

  @override
  ConsumerState<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends ConsumerState<_TextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(renameDeckControllerProvider(sessionId));
    final isEnabled = state is RenameDeckInitial;
    return TextField(
      enabled: isEnabled,
      autofocus: true,
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      onChanged: (value) {
        ref
            .read(renameDeckControllerProvider(sessionId).notifier)
            .setTitle(value);
      },
    );
  }
}

class _RenameButton extends ConsumerWidget {
  const _RenameButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final state = ref.watch(renameDeckControllerProvider(sessionId));

    final isEnabled = state is RenameDeckInitial && !state.isEmpty;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      onPressed: isEnabled ? () async => await save(ref, context) : null,
      child: TextOrCircularProgressIndicator(
        isUpdating: state is RenameDeckLoading,
        child: const Text('RENAME'),
      ),
    );
  }
}

Future<void> save(WidgetRef ref, BuildContext context) async {
  final sessionId = ref.read(sessionIdProvider)!;
  final controller = ref.read(renameDeckControllerProvider(sessionId).notifier);
  await controller.save();

  final state = ref.read(renameDeckControllerProvider(sessionId));
  if (state is RenameDeckSuccess && context.mounted) {
    context.showTextSnackBar('Renamed deck successfully.');
    Navigator.of(context).pop();
  }
}
