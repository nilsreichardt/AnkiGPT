import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/pages/deck_page/error_card.dart';
import 'package:ankigpt/src/pages/deck_page/search_bar.dart';
import 'package:ankigpt/src/pages/deck_page/warning_card.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/mnemonics_dialog.dart';
import 'package:ankigpt/src/pages/widgets/mnemonics_limit_exceeded_dialog.dart';
import 'package:ankigpt/src/pages/widgets/pagination_control.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/app_user_provider.dart';
import 'package:ankigpt/src/providers/card_feedback_status_provider.dart';
import 'package:ankigpt/src/providers/card_text_editing_controller_provider.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/dislike_provider.dart';
import 'package:ankigpt/src/providers/edit_answer_provider.dart';
import 'package:ankigpt/src/providers/edit_question_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/like_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/total_cards_counter_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart' hide Visibility;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultSection extends ConsumerWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final view = ref.watch(watchProvider(sessionId));
    final hasSessionId = view.sessionId != null;
    final totalCards = ref.watch(totalCardsCountProvider);

    return AnimatedSwitcher(
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      duration: const Duration(milliseconds: 300),
      child: hasSessionId
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Subtitle(
                  language: view.language,
                  model: view.model,
                ),
                if (view.hasError)
                  ErrorCard(
                    text: view.error,
                    onRetry: () {
                      ref.read(generateNotifierProvider.notifier).submit();
                    },
                  ),
                const CardsSearchBar(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 275),
                  child: view.isLoading && totalCards == 0
                      ? const _LoadingCards()
                      : const _ResultList(),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}

class _LoadingCards extends StatelessWidget {
  const _LoadingCards();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            const Text(
              'Generating cards... This may take a few minutes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'You can close the browser tab and come back later.',
              style: TextStyle(
                color: Colors.grey[500]!,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ResultList extends ConsumerWidget {
  const _ResultList();

  void showDeleteSnackBar(
    BuildContext context,
    WidgetRef ref,
    CardId cardId,
  ) {
    final sessionId = ref.read(sessionIdProvider)!;
    context.hideSnackBar();
    context.showTextSnackBar(
      'Card deleted.',
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          ref
              .read(deleteCardControllerProvider.notifier)
              .undo(sessionId: sessionId);
          context.hideSnackBar();
          context.showTextSnackBar('Card restored.');
        },
      ),
    );
  }

  void deleteCard(BuildContext context, WidgetRef ref, CardId cardId) {
    final sessionId = ref.read(sessionIdProvider)!;
    ref.read(deleteCardControllerProvider.notifier).delete(
          cardId: cardId,
          sessionId: sessionId,
        );
    showDeleteSnackBar(context, ref, cardId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final isOwner =
        ref.watch(watchProvider(sessionId).select((v) => v.isOwner)) ?? true;
    final totalCardsCount = ref.watch(totalCardsCountProvider);
    if (totalCardsCount == 0) {
      return const _EmptyList();
    }

    final cards = ref.watch(cardsListControllerProvider).cards;
    final currentPage =
        ref.watch(cardsListControllerProvider.select((v) => v.currentPage));
    return Column(
      children: [
        const WarningDoubleCheckCard(),
        const SizedBox(height: 12),
        SelectionArea(
          child: Column(
            key: ValueKey(
                'cards.isEmpty: ${cards.isEmpty}, currentPage: $currentPage'),
            children: [
              if (cards.isEmpty) const _EmptySearch(),
              for (final card in cards)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ResultCard(
                    allowEdit: isOwner,
                    key: ValueKey(card.id),
                    card: card,
                    onDeleted: (cardId) {
                      // We need to make the delete call at this position in the widget tree because a call in the
                      // card would lead to an error when the presses the undo button.
                      deleteCard(context, ref, cardId);
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const PaginationControl(),
      ],
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 28),
      child: Column(
        children: [
          const Icon(
            Icons.list,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Could not generate any cards for the given input. Please try again with a different input.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          MaxWidthConstrainedBox(
            maxWidth: 200,
            child: AnkiGptElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              center: true,
              onPressed: () => context.pop(),
              label: const Text('Go back'),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 28),
      child: SelectionContainer.disabled(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/empty-folder.svg',
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
              height: 150,
            ),
            const SizedBox(height: 16),
            Text(
              'Important flashcards are missing?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            MaxWidthConstrainedBox(
              maxWidth: 200,
              child: AnkiGptElevatedButton.icon(
                icon: const Icon(Icons.feedback),
                onPressed: () =>
                    launchUrl(Uri.parse('https://ankigpt.help/support')),
                label: const Text('Send feedback'),
                center: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends ConsumerStatefulWidget {
  const ResultCard({
    super.key,
    required this.card,
    required this.onDeleted,
    required this.allowEdit,
  });

  final AnkiCard card;
  final ValueChanged<CardId> onDeleted;
  final bool allowEdit;

  @override
  ConsumerState<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends ConsumerState<ResultCard> {
  bool hovering = false;

  void switchHovering() {
    setState(() {
      hovering = !hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Theme.of(context).platform.isMobile();
    return MouseRegion(
      onEnter: (_) => switchHovering(),
      onExit: (_) => switchHovering(),
      child: AnkiGptCard(
        color: Colors.white.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 6, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CardQuestion(
                    question: widget.card.question,
                    cardId: widget.card.id,
                    allowEdit: widget.allowEdit,
                  ),
                  if (widget.allowEdit)
                    _Controls(
                      // We always show the controls on mobile because there is no
                      // hover state.
                      isVisible: hovering || isMobile,
                      cardId: widget.card.id,
                      onDeleted: widget.onDeleted,
                      answer: widget.card.answer,
                      question: widget.card.question,
                    )
                ],
              ),
              const SizedBox(height: 4),
              _CardAnswer(
                allowEdit: widget.allowEdit,
                answer: widget.card.answer,
                cardId: widget.card.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardTextField extends StatefulWidget {
  const _CardTextField({
    required this.text,
    required this.onChanged,
    required this.style,
    required this.controller,
    required this.allowEdit,
  });

  final ValueChanged<String> onChanged;
  final String text;
  final TextStyle style;
  final TextEditingController controller;
  final bool allowEdit;

  @override
  State<_CardTextField> createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<_CardTextField> {
  bool hovering = false;

  void switchHovering() {
    setState(() {
      hovering = !hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.allowEdit) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge?.merge(widget.style),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => switchHovering(),
      onExit: (_) => switchHovering(),
      child: AnkiGptCard(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: hovering ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        child: TextField(
          controller: widget.controller,
          maxLines: null,
          onChanged: widget.onChanged,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          style: widget.style,
        ),
      ),
    );
  }
}

class _CardAnswer extends ConsumerStatefulWidget {
  const _CardAnswer({
    required this.cardId,
    required this.answer,
    required this.allowEdit,
  });

  final CardId cardId;
  final String answer;
  final bool allowEdit;

  @override
  ConsumerState<_CardAnswer> createState() => _CardAnswerState();
}

class _CardAnswerState extends ConsumerState<_CardAnswer> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller =
        ref.read(answerTextEditingControllerProviderProvider(widget.cardId));
    controller.text = widget.answer;
  }

  @override
  void dispose() {
    // We don't dispose the controller because it is re-used when opening the
    // page again.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CardTextField(
      allowEdit: widget.allowEdit,
      controller: controller,
      onChanged: (text) {
        final sessionId = ref.read(sessionIdProvider)!;
        ref.read(editAnswerProvider.notifier).debounce(
              cardId: widget.cardId,
              answer: text,
              sessionId: sessionId,
            );
      },
      text: widget.answer,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    );
  }
}

class _CardQuestion extends ConsumerStatefulWidget {
  const _CardQuestion({
    required this.cardId,
    required this.question,
    required this.allowEdit,
  });

  final CardId cardId;
  final String question;
  final bool allowEdit;

  @override
  ConsumerState<_CardQuestion> createState() => _CardQuestionState();
}

class _CardQuestionState extends ConsumerState<_CardQuestion> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.question);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _CardTextField(
        allowEdit: widget.allowEdit,
        controller: controller,
        text: widget.question,
        onChanged: (text) {
          final sessionId = ref.read(sessionIdProvider)!;
          ref.read(editQuestionProvider.notifier).debounce(
                cardId: widget.cardId,
                question: text,
                sessionId: sessionId,
              );
        },
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum _ControlsOptions {
  edit,
  like,
  undoLike,
  dislike,
  undoDislike,
  mnemonics,
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.isVisible,
    required this.cardId,
    required this.onDeleted,
    required this.question,
    required this.answer,
  });

  final bool isVisible;
  final CardId cardId;
  final ValueChanged<CardId> onDeleted;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DeleteButton(
          cardId: cardId,
          isVisible: isVisible,
          onDeleted: onDeleted,
        ),
        _MoreOptionsMenu(
          cardId: cardId,
          question: question,
          answer: answer,
        ),
      ],
    );
  }
}

class _MoreOptionsMenu extends ConsumerWidget {
  const _MoreOptionsMenu({
    required this.cardId,
    required this.question,
    required this.answer,
  });

  final CardId cardId;
  final String question;
  final String answer;

  void undoDislike(WidgetRef ref) {
    final sessionId = ref.read(sessionIdProvider)!;
    ref
        .read(cardFeedbackStatusControllerProvider.notifier)
        .setStatus(cardId, CardFeedbackStatus.notReviewed);
    ref.read(undoDislikeCardProvider(cardId: cardId, sessionId: sessionId));
  }

  void undoLike(WidgetRef ref) {
    final sessionId = ref.read(sessionIdProvider)!;
    ref
        .read(cardFeedbackStatusControllerProvider.notifier)
        .setStatus(cardId, CardFeedbackStatus.notReviewed);
    ref.read(undoLikeCardProvider(cardId: cardId, sessionId: sessionId));
  }

  void dislike(WidgetRef ref, BuildContext context) {
    final sessionId = ref.read(sessionIdProvider)!;
    ref
        .read(cardFeedbackStatusControllerProvider.notifier)
        .setStatus(cardId, CardFeedbackStatus.disliked);
    ref.read(
      dislikeCardProvider(
        cardId: cardId,
        sessionId: sessionId,
      ),
    );
    showCardDislikeDialog(
      context,
      cardId: cardId,
      sessionId: sessionId,
    );
  }

  void like(WidgetRef ref, BuildContext context) {
    final sessionId = ref.read(sessionIdProvider)!;
    ref
        .read(cardFeedbackStatusControllerProvider.notifier)
        .setStatus(cardId, CardFeedbackStatus.liked);

    ref.read(
      likeCardProvider(
        cardId: cardId,
        sessionId: sessionId,
      ),
    );
    showCardLikeDialog(
      context,
      sessionId: sessionId,
      cardId: cardId,
    );
  }

  void showEditTutorial(BuildContext context) {
    showModal(
      context: context,
      builder: (context) => const _EditTutorialDialog(),
    );
  }

  void showMnemonicsDialog(BuildContext context, WidgetRef ref) {
    final user = ref.read(appUserProvider).value;

    // If the user is null, we don't know if the user has enough usage, so we
    // assume that their has. This is not a problem because the backend will
    // reject the request if the user has not enough usage.
    final hasReachedMnemonicsLimit = user?.hasReachedMnemonicsLimit ?? false;

    if (hasReachedMnemonicsLimit) {
      showModal(
        context: context,
        builder: (context) => const MnemonicsLimitExceededDialog(),
      );
    } else {
      final sessionId = ref.read(sessionIdProvider)!;
      showModal(
        context: context,
        builder: (context) => MnemonicsDialog(
          cardId: cardId,
          sessionId: sessionId,
          answer: answer,
          question: question,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(cardFeedbackStatusControllerProvider)[cardId] ??
        CardFeedbackStatus.notReviewed;
    final hasLiked = status == CardFeedbackStatus.liked;
    final hasDisliked = status == CardFeedbackStatus.disliked;

    return PopupMenuButton<_ControlsOptions>(
      tooltip: 'More options (edit, like, dislike, mnemonics)',
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _ControlsOptions.mnemonics,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            leading: Icon(Icons.psychology),
            mouseCursor: SystemMouseCursors.click,
            title: Text('Generate mnemonic (beta)'),
          ),
        ),
        const PopupMenuItem(
          value: _ControlsOptions.edit,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            leading: Icon(Icons.edit),
            mouseCursor: SystemMouseCursors.click,
            title: Text('Edit'),
          ),
        ),
        if (hasLiked)
          const PopupMenuItem(
            value: _ControlsOptions.undoLike,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              leading: Icon(Icons.thumb_up),
              mouseCursor: SystemMouseCursors.click,
              title: Text('Undo like'),
            ),
          ),
        if (hasDisliked)
          const PopupMenuItem(
            value: _ControlsOptions.undoDislike,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              leading: Icon(Icons.thumb_down),
              mouseCursor: SystemMouseCursors.click,
              title: Text('Undo dislike'),
            ),
          ),
        if (!hasDisliked && !hasLiked) ...const [
          PopupMenuItem(
            value: _ControlsOptions.like,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              leading: Icon(Icons.thumb_up),
              mouseCursor: SystemMouseCursors.click,
              title: Text('I like this card'),
            ),
          ),
          PopupMenuItem(
            value: _ControlsOptions.dislike,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              leading: Icon(Icons.thumb_down),
              mouseCursor: SystemMouseCursors.click,
              title: Text('I dislike this card'),
            ),
          )
        ],
      ],
      onSelected: (value) {
        return switch (value) {
          _ControlsOptions.edit => showEditTutorial(context),
          _ControlsOptions.dislike => dislike(ref, context),
          _ControlsOptions.like => like(ref, context),
          _ControlsOptions.undoDislike => undoDislike(ref),
          _ControlsOptions.undoLike => undoDislike(ref),
          _ControlsOptions.mnemonics => showMnemonicsDialog(context, ref),
        };
      },
    );
  }
}

class _EditTutorialDialog extends StatelessWidget {
  const _EditTutorialDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tutorial: Edit card'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 400,
            child: TutorialVideoPlayer(
              aspectRatio: 16 / 9,
              videoUrl:
                  'https://firebasestorage.googleapis.com/v0/b/ankigpt-prod.appspot.com/o/assets%2Fedit-card-tutorial.mp4?alt=media&token=4473f746-93b9-4fb3-a5c1-4489854f1779',
            ),
          ),
          SizedBox(height: 10),
          Text('Just click on the card to edit it. Auto-save is enabled.'),
        ],
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

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.cardId,
    required this.isVisible,
    required this.onDeleted,
  });

  final CardId cardId;
  final bool isVisible;
  final ValueChanged<CardId> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardIconButton(
      isVisible: isVisible,
      child: IconButton(
        tooltip: 'Delete',
        onPressed: () => onDeleted(cardId),
        icon: const Icon(Icons.delete),
      ),
    );
  }
}

class _CardIconButton extends StatelessWidget {
  const _CardIconButton({
    required this.isVisible,
    required this.child,
  });

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      // Adding the default transitionBuilder here fixes
      // https://github.com/flutter/flutter/issues/121336. The bug can occur
      // when clicking the card very quickly.
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Opacity(
        key: ValueKey(isVisible),
        opacity: isVisible ? 1 : 0,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: child,
        ),
      ),
    );
  }
}

class _Subtitle extends ConsumerWidget {
  const _Subtitle({
    required this.language,
    required this.model,
  });

  final Language? language;
  final Model? model;

  String getTitle(WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final view = ref.watch(watchProvider(sessionId));

    if (view.hasFile) {
      final fileName =
          ref.watch(watchProvider(sessionId).select((view) => view.fileName));
      return fileName ?? 'File';
    }

    return '${(view.inputText?.length ?? 0) > 30 ? view.inputText?.substring(0, 30) : view.inputText}...';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final isSearching = query.isNotEmpty;

    int cardsCount = 0;
    if (isSearching) {
      final view = ref.watch(cardsListControllerProvider);
      cardsCount = view.cards.length;
    } else {
      cardsCount = ref.watch(totalCardsCountProvider);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Text(
        'Deck: "${getTitle(ref)}", Language: ${language == null ? '...' : language!.getDisplayName()}, $cardsCount cards',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}

extension on TargetPlatform {
  bool isMobile() =>
      this == TargetPlatform.iOS || this == TargetPlatform.android;
}
