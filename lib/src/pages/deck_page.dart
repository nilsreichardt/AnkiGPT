import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/home_page/controls.dart';
import 'package:ankigpt/src/pages/session_page/result_section.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/footer.dart';
import 'package:ankigpt/src/pages/widgets/input_text_field.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckPage extends ConsumerStatefulWidget {
  const DeckPage({
    super.key,
    required this.sessionId,
    this.page,
  });

  final SessionId? sessionId;
  final int? page;

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
        logger.v('Watch session: $sessionId');
      }

      final page = widget.page;
      if (page != null) {
        ref.read(cardsListControllerProvider.notifier).setPage(page);
        logger.v('Set page: $page');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Keep provider alive.
    ref.watch(watchProvider(widget.sessionId ?? 'does-not-exist'));

    return ProviderScope(
      overrides: [
        sessionIdProvider.overrideWithValue(widget.sessionId),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const _BackButton(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: ScrollController(
              initialScrollOffset: widget.page != null ? 250 : 0,
            ),
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
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: () => context.go('/'),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _Input(),
          Controls(),
          ResultSection(),
        ],
      ),
    );
  }
}

class _Input extends ConsumerWidget {
  const _Input();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final view = ref.watch(watchProvider(sessionId));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: view.hasFile
          ? const _FileCard()
          : InputTextField(
              controller: TextEditingController(text: view.inputText),
              isEnabled: false,
            ),
    );
  }
}

class _FileCard extends ConsumerWidget {
  const _FileCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final fileName =
        ref.watch(watchProvider(sessionId).select((view) => view.fileName));
    const borderRadius = BorderRadius.all(Radius.circular(12));
    return AnkiGptCard(
      borderRadius: borderRadius,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 40, 12, 40),
          child: Column(
            children: [
              const Icon(Icons.upload_file),
              const SizedBox(height: 13),
              Text(fileName ?? 'File picked.'),
              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }
}
