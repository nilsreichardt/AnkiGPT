import 'dart:math';

import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/deck_page/error_card.dart';
import 'package:ankigpt/src/pages/home_page/deck_rename_dialog.dart';
import 'package:ankigpt/src/pages/home_page/plus_dialog.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/elevated_button.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/plus_badge.dart';
import 'package:ankigpt/src/pages/widgets/scroll_to.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MyDecksSection extends ConsumerWidget {
  const MyDecksSection({
    super.key,
    this.isTesting = false,
  });

  /// Determines whether the app is in testing mode.
  final bool isTesting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      maxWidth: 900,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          key: ref.read(homePageScrollViewProvider).myDecksSectionKey,
          children: [
            const SectionTitle(title: 'My Decks'),
            const _Subtitle(),
            const SizedBox(height: 32),
            _List(isTesting: isTesting),
            const LoadMoreButton(),
            const LoadLessButton(),
            const _Loading(),
            const _Error(),
          ],
        ),
      ),
    );
  }
}

class _Subtitle extends ConsumerWidget {
  const _Subtitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountOfDecks = ref.watch(deckListControllerProvider.select(
      (s) => s.decks.length,
    ));
    return Text(
      'Shows the $amountOfDecks latest decks you created.',
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}

class _Loading extends ConsumerWidget {
  const _Loading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deckListControllerProvider);
    final isLoading = state is DeckListLoading;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isLoading ? const CircularProgressIndicator() : const SizedBox(),
    );
  }
}

class _List extends ConsumerWidget {
  const _List({
    required this.isTesting,
  });

  final bool isTesting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(deckListControllerProvider.select((s) => s.decks));
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 20,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            for (final deck in decks)
              deck.maybeWhen(
                created: (questions, createdAt, name, sessionId, model,
                        numberOfCards) =>
                    _CreatedHistoryDeck(
                  questions: questions,
                  createdAt: deck.createdAt,
                  name: name,
                  sessionId: sessionId,
                  model: model,
                  numberOfCards: numberOfCards,
                ),
                loading: (createdAt, name, numberOfCards, sessionId, model) =>
                    _LoadingHistoryDeck(
                  createdAt: deck.createdAt,
                  name: name,
                  numberOfCards: numberOfCards,
                  isTesting: isTesting,
                  sessionId: sessionId,
                  model: model,
                ),
                error:
                    (error, createdAt, name, numberOfCards, sessionId, model) =>
                        _ErrorHistoryDeck(
                  createdAt: deck.createdAt,
                  error: error,
                  name: name,
                  numberOfCards: numberOfCards,
                  sessionId: sessionId,
                  model: model,
                ),
                orElse: () => const SizedBox(),
              )
          ],
        ),
      ),
    );
  }
}

class _Error extends ConsumerWidget {
  const _Error();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deckListControllerProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: state is DeckListError
          ? ErrorCard(text: state.message)
          : const SizedBox(),
    );
  }
}

class LoadMoreButton extends ConsumerWidget {
  const LoadMoreButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPlus = ref.watch(hasPlusProvider);
    final state = ref.watch(deckListControllerProvider);
    final hasMoreButton = switch (state) {
      DeckListLoaded(hasMore: final hasMore) => hasMore,
      _ => false,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: hasMoreButton
          ? AnkiGptElevatedButton.icon(
              key: ref.read(homePageScrollViewProvider).loadMoreDecksButton,
              color: Colors.transparent,
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1.4,
              ),
              onPressed: () async {
                if (!hasPlus) {
                  showPlusDialog(context);
                  return;
                }
                final controller =
                    ref.read(deckListControllerProvider.notifier);
                controller.loadMore();
              },
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Load more decks'),
                  if (!hasPlus) ...const [
                    SizedBox(width: 8),
                    SizedBox(
                      width: 38,
                      child: PlusBadge(withText: false),
                    )
                  ]
                ],
              ),
              icon: const Icon(Icons.update),
              mainAxisSize: MainAxisSize.min,
            )
          : const SizedBox(),
    );
  }
}

class LoadLessButton extends ConsumerWidget {
  const LoadLessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deckListControllerProvider);
    final hasLessButton = switch (state) {
      DeckListLoaded(hasLess: final hasLess) => hasLess,
      _ => false,
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: hasLessButton
          ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                  onPressed: () {
                    final controller =
                        ref.read(deckListControllerProvider.notifier);
                    controller.loadLess();

                    Future.delayed(const Duration(milliseconds: 16)).then((_) {
                      final loadMoreButtonKey = ref
                          .read(homePageScrollViewProvider)
                          .loadMoreDecksButton;
                      scrollTo(
                        context: context,
                        key: loadMoreButtonKey,
                        duration: Duration.zero,
                      );
                    });
                  },
                  child: const Text('Load less')),
            )
          : const SizedBox(),
    );
  }
}

class _CreatedHistoryDeck extends ConsumerWidget {
  const _CreatedHistoryDeck({
    required this.name,
    required this.createdAt,
    required this.questions,
    required this.numberOfCards,
    required this.sessionId,
    required this.model,
  });

  final String name;
  final DateTime createdAt;
  final List<String> questions;
  final int numberOfCards;
  final SessionId sessionId;
  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasMoreThanFiveQuestions = questions.length > 5;
    return _HistoryDeckBase(
      numberOfCards: numberOfCards,
      model: model,
      name: name,
      createdAt: createdAt,
      sessionId: sessionId,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          for (final question in questions.sublist(0, min(questions.length, 5)))
            Text(
              '• $question',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (hasMoreThanFiveQuestions) ...[
            const SizedBox(height: 12),
            const Text(
              '...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class _LoadingHistoryDeck extends StatelessWidget {
  const _LoadingHistoryDeck({
    required this.name,
    required this.createdAt,
    required this.numberOfCards,
    required this.isTesting,
    required this.sessionId,
    required this.model,
  });

  final String name;
  final DateTime createdAt;
  final int numberOfCards;
  final bool isTesting;
  final SessionId sessionId;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return _HistoryDeckBase(
      model: model,
      numberOfCards: numberOfCards,
      name: name,
      createdAt: createdAt,
      sessionId: sessionId,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Tooltip(
          message: 'Still generating...',
          child: CircularProgressIndicator(
            // If we're testing, we want to make sure the progress indicator
            // uses a fixed value so that we can test the UI. Otherwise, the
            // pumpAndSettle() call in the tests will never complete.
            value: isTesting ? 0.5 : null,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class _ErrorHistoryDeck extends StatelessWidget {
  const _ErrorHistoryDeck({
    required this.name,
    required this.createdAt,
    required this.error,
    required this.numberOfCards,
    required this.sessionId,
    required this.model,
  });

  final String name;
  final DateTime createdAt;
  final String? error;
  final int numberOfCards;
  final SessionId sessionId;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return _HistoryDeckBase(
        numberOfCards: numberOfCards,
        model: model,
        name: name,
        sessionId: sessionId,
        createdAt: createdAt,
        color: Theme.of(context).colorScheme.error,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 26, 16, 12),
          child: Text(
            'Error generating cards',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}

class _HistoryDeckBase extends StatelessWidget {
  const _HistoryDeckBase({
    required this.name,
    required this.createdAt,
    required this.body,
    required this.numberOfCards,
    required this.sessionId,
    required this.model,
    this.color = Colors.blue,
  });

  final String? name;
  final DateTime? createdAt;
  final Color color;
  final Widget body;
  final int numberOfCards;
  final SessionId sessionId;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AnkiGptCard(
        onPressed: () => context.go('/deck/$sessionId'),
        color: color.withOpacity(0.1),
        padding: const EdgeInsets.all(22),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name != null)
                      Text(
                        name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                        '${DateFormat.yMEd().add_jms().format(createdAt!)}, $numberOfCards cards (${model.getUiText()})',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.75),
                            )),
                    body,
                  ],
                ),
              ),
              _MoreOptionsMenu(
                title: name ?? 'Untitled',
                sessionId: sessionId,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum _MoreOptionsMenuAction {
  rename,
}

class _MoreOptionsMenu extends StatelessWidget {
  const _MoreOptionsMenu({
    required this.title,
    required this.sessionId,
  });

  /// The title of the deck.
  final String title;

  final SessionId sessionId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MoreOptionsMenuAction>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _MoreOptionsMenuAction.rename,
          child: ListTile(
            title: Text('Rename'),
            leading: Icon(Icons.edit),
            mouseCursor: SystemMouseCursors.click,
          ),
        )
      ],
      onSelected: (value) {
        switch (value) {
          case _MoreOptionsMenuAction.rename:
            showDeckRenameDialog(
              context: context,
              title: title,
              sessionId: sessionId,
            );
            break;
        }
      },
    );
  }
}
