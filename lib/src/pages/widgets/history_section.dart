import 'dart:math';

import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/history_deck_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class HistorySection extends ConsumerWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(historyDeckListProvider).when(
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
                      session.when(
                        created:
                            (questions, createdAt, name, dto, numberOfCards) =>
                                _CreatedHistoryDeck(
                          questions: questions,
                          createdAt: session.createdAt,
                          name: name,
                          dto: dto,
                          numberOfCards: numberOfCards,
                        ),
                        loading: (createdAt, name, numberOfCards) =>
                            _LoadingHistoryDeck(
                          createdAt: session.createdAt,
                          name: name,
                          numberOfCards: numberOfCards,
                        ),
                        error: (error, createdAt, name, numberOfCards) =>
                            _ErrorHistoryDeck(
                          createdAt: session.createdAt,
                          error: error,
                          name: name,
                          numberOfCards: numberOfCards,
                        ),
                      )
                  ],
                ),
              ),
            );
          },
          error: (error, _) => _ErrorText(error: '$error'),
          loading: () => const SizedBox(),
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
    required this.dto,
    required this.numberOfCards,
  });

  final String name;
  final DateTime createdAt;
  final List<String> questions;
  final SessionDto dto;
  final int numberOfCards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasMoreThanFiveQuestions = questions.length > 5;
    return _HistoryDeckBase(
      numberOfCards: numberOfCards,
      name: name,
      onTap: () {
        ref.read(generateStateProvider.notifier).setSuccess(
              sessionId: dto.id,
              generatedCards: dto.cards?.values.toList() ?? [],
              downloadUrl: dto.csv!.downloadUrl,
              language: dto.language!,
            );
      },
      createdAt: createdAt,
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
  });

  final String name;
  final DateTime createdAt;
  final int numberOfCards;

  @override
  Widget build(BuildContext context) {
    return _HistoryDeckBase(
      numberOfCards: numberOfCards,
      name: name,
      createdAt: createdAt,
      body: const Padding(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Tooltip(
          message: 'Still generating...',
          child: CircularProgressIndicator(
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
  });

  final String name;
  final DateTime createdAt;
  final String? error;
  final int numberOfCards;

  @override
  Widget build(BuildContext context) {
    return _HistoryDeckBase(
        numberOfCards: numberOfCards,
        name: name,
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
    this.color = Colors.blue,
    this.onTap,
  });

  final String? name;
  final DateTime? createdAt;
  final Color color;
  final Widget body;
  final VoidCallback? onTap;
  final int numberOfCards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: onTap,
          borderRadius: defaultAnkiGptBorderRadius,
          child: AnkiGptCard(
            color: color,
            padding: const EdgeInsets.all(22),
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
                    '${DateFormat.yMEd().add_jms().format(createdAt!)}, $numberOfCards cards',
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
      ),
    );
  }
}
