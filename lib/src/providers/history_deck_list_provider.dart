import 'dart:math';

import 'package:ankigpt/src/models/history_deck.dart';
import 'package:ankigpt/src/providers/stream_session_docs_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_deck_list_provider.g.dart';

@riverpod
Stream<List<HistoryDeck>> historyDeckList(HistoryDeckListRef ref) {
  // Map the stream of session docs to a stream of history decks.
  final sessions = ref.watch(streamSessionDocsProvider);
  if (sessions.value == null) {
    return Stream.value([]);
  }

  return Stream.value(
    sessions.value?.map((dto) {
          final name =
              '${dto.slideContent.substring(0, min(dto.slideContent.length, 150))}...';
          if (dto.error != null) {
            return HistoryDeck.error(
                createdAt: dto.createdAt,
                message: dto.error!,
                name: name,
                numberOfCards: dto.numberOfCards);
          }

          if (!dto.isCompleted) {
            return HistoryDeck.loading(
              createdAt: dto.createdAt,
              name: name,
              numberOfCards: dto.numberOfCards,
            );
          }

          return HistoryDeck.created(
            createdAt: dto.createdAt,
            name: name,
            numberOfCards: dto.numberOfCards,
            questions: dto.cards?.values.map((c) => c.question).toList() ?? [],
            sessionDto: dto,
          );
        }).toList() ??
        [],
  );
}
