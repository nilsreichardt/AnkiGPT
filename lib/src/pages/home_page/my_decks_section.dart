import 'dart:math';

import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
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
          key: ref.read(homePageScollViewProvider).myDecksSectionKey,
          children: [
            const SectionTitle(title: 'My Decks'),
            const Text(
              'Shows the 10 latest decks you created.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 32),
            ref.watch(deckListProvider).when(
                  data: (sessions) {
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
                            for (final session in sessions)
                              session.maybeWhen(
                                created: (questions, createdAt, name, sessionId,
                                        model, numberOfCards) =>
                                    _CreatedHistoryDeck(
                                  questions: questions,
                                  createdAt: session.createdAt,
                                  name: name,
                                  sessionId: sessionId,
                                  model: model,
                                  numberOfCards: numberOfCards,
                                ),
                                loading: (createdAt, name, numberOfCards,
                                        sessionId, model) =>
                                    _LoadingHistoryDeck(
                                  createdAt: session.createdAt,
                                  name: name,
                                  numberOfCards: numberOfCards,
                                  isTesting: isTesting,
                                  sessionId: sessionId,
                                  model: model,
                                ),
                                error: (error, createdAt, name, numberOfCards,
                                        sessionId, model) =>
                                    _ErrorHistoryDeck(
                                  createdAt: session.createdAt,
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
                  },
                  error: (error, _) => _ErrorText(error: '$error'),
                  loading: () => const SizedBox(),
                )
          ],
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Error: $error\n\nPlease try again later or contact support.',
      style: TextStyle(color: Theme.of(context).colorScheme.error),
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
      ),
    );
  }
}
