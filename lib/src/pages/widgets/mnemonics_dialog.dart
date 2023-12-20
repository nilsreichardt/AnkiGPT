import 'dart:async';

import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/providers/app_user_provider.dart';
import 'package:ankigpt/src/providers/mnemonics_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MnemonicsDialog extends ConsumerStatefulWidget {
  const MnemonicsDialog({
    super.key,
    required this.cardId,
    required this.sessionId,
    required this.question,
    required this.answer,
  });

  final CardId cardId;
  final SessionId sessionId;
  final String question;
  final String answer;

  @override
  ConsumerState<MnemonicsDialog> createState() => _MnemonicsDialogState();
}

class _MnemonicsDialogState extends ConsumerState<MnemonicsDialog> {
  MnemonicsController? controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // When the user opens the dialog, we directly generate a new mnemonic.
      controller = ref.read(mnemonicsControllerProvider.notifier);
      controller?.generate(
        answer: widget.answer,
        cardId: widget.cardId,
        sessionId: widget.sessionId,
        question: widget.question,
      );
    });
  }

  @override
  void dispose() {
    // When the user closes the dialog, we assume that the user doesn't like the
    // generated mnemonic and we dislike it.
    unawaited(controller?.dislike());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mnemonicsControllerProvider);
    return AlertDialog(
      title: const Text('Generate mnemonic'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
          minWidth: 600,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnkiGptCard(
                color: Colors.grey.withOpacity(0.2),
                child: const SelectableText(
                  'Mnemonics are memory aids that use associations, such as visual images, patterns, or rhymes, to help encode, store, and retrieve information more easily, making them highly effective for studying by enhancing recall and retention of complex material.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AnkiGptCard(
                child: SelectableText(
                  'Front: ${widget.question}\n\nBack: ${widget.answer}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: state.when(
                  appending: () => const _Appending(),
                  generating: () => const _Generating(),
                  error: (message) => _ErrorText(message: message),
                  loaded: (mnemonic, _) => _Loaded(
                    mnemonic: mnemonic,
                    cardId: widget.cardId,
                    answer: widget.answer,
                    question: widget.question,
                    sessionId: widget.sessionId,
                  ),
                ),
              ),
              _RegenerateButton(
                answer: widget.answer,
                cardId: widget.cardId,
                question: widget.question,
                sessionId: widget.sessionId,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        _AppendButton(
          cardId: widget.cardId,
          sessionId: widget.sessionId,
        )
      ],
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}

class _Generating extends StatelessWidget {
  const _Generating();

  @override
  Widget build(BuildContext context) {
    return const Column(
      key: ValueKey('loading'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text("It's cooking..."),
      ],
    );
  }
}

class _Appending extends StatelessWidget {
  const _Appending();

  @override
  Widget build(BuildContext context) {
    return const Column(
      key: ValueKey('appending'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text("Appending..."),
      ],
    );
  }
}

class _Loaded extends ConsumerStatefulWidget {
  const _Loaded({
    required this.mnemonic,
    required this.question,
    required this.answer,
    required this.cardId,
    required this.sessionId,
  });

  final String mnemonic;
  final String question;
  final String answer;
  final CardId cardId;
  final SessionId sessionId;

  @override
  ConsumerState<_Loaded> createState() => _LoadedState();
}

class _LoadedState extends ConsumerState<_Loaded> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.mnemonic);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('loaded'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            labelText: 'Mnemonic',
          ),
          maxLines: null,
          onChanged: ref.read(mnemonicsControllerProvider.notifier).update,
        ),
      ],
    );
  }
}

class _RegenerateButton extends ConsumerWidget {
  const _RegenerateButton({
    required this.question,
    required this.answer,
    required this.cardId,
    required this.sessionId,
  });

  final String question;
  final String answer;
  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReachedMnemonicsLimit =
        ref.watch(appUserProvider).value?.hasReachedMnemonicsLimit ?? false;

    final state = ref.watch(mnemonicsControllerProvider);
    final isLoading =
        state is MnemonicsStateGenerating || state is MnemonicsStateAppending;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLoading
          ? const SizedBox()
          : Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Tooltip(
                  textAlign: TextAlign.center,
                  message: hasReachedMnemonicsLimit
                      ? 'You reached your monthly limit of mnemonics.\nPlease upgrade to the plus plan to get unlimited mnemonics.'
                      : 'Generates a different mnemonic',
                  child: TextButton(
                    onPressed: !hasReachedMnemonicsLimit
                        ? () {
                            final controller =
                                ref.read(mnemonicsControllerProvider.notifier);
                            controller.generate(
                              answer: answer,
                              cardId: cardId,
                              sessionId: sessionId,
                              question: question,
                            );
                          }
                        : null,
                    child: const Text('Regenerate'),
                  ),
                ),
              ),
            ),
    );
  }
}

class _AppendButton extends ConsumerWidget {
  const _AppendButton({
    required this.cardId,
    required this.sessionId,
  });

  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mnemonicsControllerProvider);
    final isLoaded = state is MnemonicsStateLoaded;
    return Tooltip(
      message: 'Appends the mnemonic to the card',
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        onPressed: isLoaded
            ? () async {
                final controller =
                    ref.read(mnemonicsControllerProvider.notifier);
                await controller.append(
                  cardId: cardId,
                  sessionId: sessionId,
                );

                final state = ref.read(mnemonicsControllerProvider);
                if (state is MnemonicsStateAppending && context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            : null,
        child: const Text('Append'),
      ),
    );
  }
}
