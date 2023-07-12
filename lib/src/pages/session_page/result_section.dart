import 'dart:math';

import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/pages/session_page/error_card.dart';
import 'package:ankigpt/src/pages/session_page/search_bar.dart';
import 'package:ankigpt/src/pages/session_page/warning_card.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/pagination_control.dart';
import 'package:ankigpt/src/pages/widgets/video_player.dart';
import 'package:ankigpt/src/providers/card_feedback_status_provider.dart';
import 'package:ankigpt/src/providers/cards_list_controller.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/dislike_provider.dart';
import 'package:ankigpt/src/providers/edit_answer_provider.dart';
import 'package:ankigpt/src/providers/edit_question_provider.dart';
import 'package:ankigpt/src/providers/like_provider.dart';
import 'package:ankigpt/src/providers/search_provider.dart';
import 'package:ankigpt/src/providers/session_id_provider.dart';
import 'package:ankigpt/src/providers/total_cards_counter_provider.dart';
import 'package:ankigpt/src/providers/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultSection extends ConsumerWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionId = ref.watch(sessionIdProvider)!;
    final view = ref.watch(watchProvider(sessionId));
    final hasSessionId = view.sessionId != null;

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
                _Subtitle(language: view.language),
                if (view.hasError) ErrorCard(text: view.error),
                const CardsSearchBar(),
                if (view.isLoading)
                  const _LoadingCards()
                else
                  const _ResultList(),
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
    final totalCardsCount = ref.watch(totalCardsCountProvider);
    if (totalCardsCount == 0) {
      return const _EmptyList();
    }

    final cards = ref.watch(cardsListControllerProvider).cards;
    return Column(
      children: [
        const WarningDoubleCheckCard(),
        const SizedBox(height: 12),
        SelectionArea(
          child: AnimationLimiter(
            // We don't use cards.length as key because we don't want to animate all
            // cards when the list changes.
            key: ValueKey(cards.isEmpty),
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 20,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  if (cards.isEmpty) const _EmptySearch(),
                  for (final card in cards)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ResultCard(
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
              onPressed: () =>
                  launchUrl(Uri.parse('https://ankigpt.help/support')),
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
            ElevatedButton.icon(
              icon: const Icon(Icons.feedback),
              onPressed: () =>
                  launchUrl(Uri.parse('https://ankigpt.help/support')),
              label: const Text('Send feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends ConsumerStatefulWidget {
  const ResultCard({
    Key? key,
    required this.card,
    required this.onDeleted,
  }) : super(key: key);

  final AnkiCard card;
  final ValueChanged<CardId> onDeleted;

  @override
  ConsumerState<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends ConsumerState<ResultCard> {
  bool hovering = false;
  int randomNumber = 0;

  void switchHovering() {
    setState(() {
      hovering = !hovering;

      // We need to add a random number to the key to prevent having two widgets
      // with the same key when the user hovers over the card multiple times. If
      // the user hovers over the same card multiple times, the widget with the
      // old key will still be in the tree because of the animation.
      randomNumber = Random().nextInt(1000000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => switchHovering(),
      onExit: (_) => switchHovering(),
      child: AnkiGptCard(
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
                  ),
                  _Controls(
                    isHovering: hovering,
                    cardId: widget.card.id,
                    randomNumber: randomNumber,
                    onDeleted: widget.onDeleted,
                  )
                ],
              ),
              const SizedBox(height: 4),
              _CardAnswer(
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
  });

  final ValueChanged<String> onChanged;
  final String text;
  final TextStyle style;

  @override
  State<_CardTextField> createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<_CardTextField> {
  bool hovering = false;
  int randomNumber = 0;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  void switchHovering() {
    setState(() {
      hovering = !hovering;

      // We need to add a random number to the key to prevent having two widgets
      // with the same key when the user hovers over the card multiple times. If
      // the user hovers over the same card multiple times, the widget with the
      // old key will still be in the tree because of the animation.
      randomNumber = Random().nextInt(1000000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => switchHovering(),
      onExit: (_) => switchHovering(),
      child: AnkiGptCard(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: hovering ? Colors.grey.withOpacity(0.1) : Colors.transparent,
        child: TextField(
          controller: controller,
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

class _CardAnswer extends ConsumerWidget {
  const _CardAnswer({
    required this.cardId,
    required this.answer,
  });

  final CardId cardId;
  final String answer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardTextField(
      onChanged: (text) {
        final sessionId = ref.read(sessionIdProvider)!;
        ref.read(editAnswerProvider.notifier).debounce(
              cardId: cardId,
              answer: text,
              sessionId: sessionId,
            );
      },
      text: answer,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 14,
      ),
    );
  }
}

class _CardQuestion extends ConsumerWidget {
  const _CardQuestion({
    required this.cardId,
    required this.question,
  });

  final CardId cardId;
  final String question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: _CardTextField(
        text: question,
        onChanged: (text) {
          final sessionId = ref.read(sessionIdProvider)!;
          ref.read(editQuestionProvider.notifier).debounce(
                cardId: cardId,
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

class _Controls extends ConsumerWidget {
  const _Controls({
    required this.isHovering,
    required this.cardId,
    required this.randomNumber,
    required this.onDeleted,
  });

  final bool isHovering;
  final CardId cardId;
  final int randomNumber;
  final ValueChanged<CardId> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(cardFeedbackStatusControllerProvider)[cardId] ??
        CardFeedbackStatus.notReviewed;
    final hasLiked = status == CardFeedbackStatus.liked;
    final hasDisliked = status == CardFeedbackStatus.disliked;
    return IconTheme(
      data: Theme.of(context).iconTheme.copyWith(
            size: 15,
          ),
      child: Row(
        children: [
          _EditButton(
            isVisibile: isHovering,
            randomNumber: randomNumber,
          ),
          _DeleteButton(
            cardId: cardId,
            isVisibile: isHovering,
            randomNumber: randomNumber,
            onDeleted: onDeleted,
          ),
          if (hasLiked)
            _UndoLikeButton(
              cardId: cardId,
            ),
          if (hasDisliked)
            _UndoDislikeButton(
              cardId: cardId,
            ),
          if (!hasDisliked && !hasLiked)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Opacity(
                key: ValueKey('$randomNumber + $isHovering'),
                opacity: isHovering ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !isHovering,
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: 'Dislike, if this is a bad card.',
                        onPressed: () {
                          final sessionId = ref.read(sessionIdProvider)!;
                          ref
                              .read(
                                  cardFeedbackStatusControllerProvider.notifier)
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
                        },
                        icon: const Icon(Icons.thumb_down),
                      ),
                      IconButton(
                        tooltip: 'Like, if this is a good card.',
                        onPressed: () {
                          final sessionId = ref.read(sessionIdProvider)!;
                          ref
                              .read(
                                  cardFeedbackStatusControllerProvider.notifier)
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
                        },
                        icon: const Icon(Icons.thumb_up),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    required this.isVisibile,
    required this.randomNumber,
  });

  final bool isVisibile;
  final int randomNumber;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Opacity(
        key: ValueKey('$randomNumber + $isVisibile'),
        opacity: isVisibile ? 1 : 0,
        child: IgnorePointer(
          ignoring: !isVisibile,
          child: IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModal(
                context: context,
                builder: (context) => AlertDialog(
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
                      Text(
                          'Just click on the card to edit it. Auto-save is enabled.'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.cardId,
    required this.isVisibile,
    required this.randomNumber,
    required this.onDeleted,
  });

  final CardId cardId;
  final bool isVisibile;
  final int randomNumber;
  final ValueChanged<CardId> onDeleted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Opacity(
        key: ValueKey('$isVisibile + $randomNumber'),
        opacity: isVisibile ? 1 : 0,
        child: IgnorePointer(
          ignoring: !isVisibile,
          child: IconButton(
            tooltip: 'Delete',
            onPressed: () => onDeleted(cardId),
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}

class _UndoLikeButton extends ConsumerWidget {
  const _UndoLikeButton({
    required this.cardId,
  });

  final CardId cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Undo like',
      onPressed: () {
        final sessionId = ref.read(sessionIdProvider)!;
        ref
            .read(cardFeedbackStatusControllerProvider.notifier)
            .setStatus(cardId, CardFeedbackStatus.notReviewed);
        ref.read(undoLikeCardProvider(cardId: cardId, sessionId: sessionId));
      },
      icon: const Icon(Icons.thumb_up),
    );
  }
}

class _UndoDislikeButton extends ConsumerWidget {
  const _UndoDislikeButton({
    required this.cardId,
  });

  final CardId cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Undo dislike',
      onPressed: () {
        final sessionId = ref.read(sessionIdProvider)!;
        ref
            .read(cardFeedbackStatusControllerProvider.notifier)
            .setStatus(cardId, CardFeedbackStatus.notReviewed);
        ref.read(undoDislikeCardProvider(cardId: cardId, sessionId: sessionId));
      },
      icon: const Icon(Icons.thumb_down),
    );
  }
}

class _Subtitle extends ConsumerWidget {
  const _Subtitle({
    required this.language,
  });

  final Language? language;

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
        'Detected language: ${language == null ? '...' : language!.getDisplayName()}, $cardsCount cards',
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
