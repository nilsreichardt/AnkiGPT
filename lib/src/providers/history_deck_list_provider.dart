import 'dart:math';

import 'package:ankigpt/src/models/history_deck.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/session_dto.dart';
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
          final name = _getName(dto.input);
          if (dto.error != null) {
            return HistoryDeck.error(
                createdAt: dto.createdAt,
                message: dto.error!,
                name: name,
                numberOfCards: dto.numberOfCards);
          }

          if (dto.status == SessionStatus.running) {
            return HistoryDeck.loading(
              createdAt: dto.createdAt,
              name: name,
              numberOfCards: dto.numberOfCards,
            );
          }

          final questions =
              (dto.cards?.values.map((c) => c.question).toList() ?? [])..sort();
          return HistoryDeck.created(
            createdAt: dto.createdAt,
            name: name,
            numberOfCards: dto.numberOfCards,
            questions:
                questions.length < 5 ? questions : questions.sublist(0, 5),
            sessionDto: dto,
          );
        }).toList() ??
        [],
  );
}

String _getName(Input input) {
  switch (input.type) {
    case InputType.file:
      return input.file?.name ?? 'File';
    case InputType.text:
      final t = (input.text ?? '').replaceAll('\n', ' ');
      return '${t.substring(0, min(t.length, 150))}...';
  }
}
