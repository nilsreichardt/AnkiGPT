import 'dart:math';

import 'package:ankigpt/src/models/deck_preview.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/providers/clock_provider.dart';
import 'package:ankigpt/src/providers/stream_session_docs_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_list_provider.g.dart';

const deckListBatchSize = 5;

@riverpod
class DeckListController extends _$DeckListController {
  final List<ProviderSubscription<AsyncValue<List<SessionDto>>>>
      _subscriptions = [];
  bool _hasInitialize = false;

  @override
  DeckListState build() {
    ref.onDispose(dispose);

    final loadingState = loadMore();
    _hasInitialize = true;

    return loadingState;
  }

  /// Loads more cards.
  ///
  /// Returns loading state which is primarily used for the [build] method.
  DeckListState loadMore() {
    final batches =
        _hasInitialize ? state.batches : <BatchId, List<DeckPreview>>{};
    final loadingState = DeckListLoading(batches: batches);
    state = loadingState;

    final clock = ref.read(clockProvider);
    final batchId = clock.now().millisecondsSinceEpoch;
    final lastCreatedAt = batches.values.lastOrNull?.lastOrNull?.createdAt;

    final sub = ref
        .listen(streamSessionDocsProvider(lastCreatedAt: lastCreatedAt),
            (previous, next) {
      if (next.hasError) {
        state = DeckListError(
          message: '${next.error}',
          batches: state.batches,
        );
        return;
      }

      final value = next.value;
      if (value == null) {
        return;
      }

      state = DeckListLoaded(
        batches: {
          ...state.batches,
          batchId: value.map((e) => e.toDeckPreview()).toList(),
        },
        hasMore: value.length >= deckListBatchSize,
        hasLess: state.batches.isNotEmpty,
      );
    });

    _subscriptions.add(sub);

    return DeckListLoading(batches: batches);
  }

  void loadLess() {
    final sub = _subscriptions.removeLast();
    sub.close();

    final batches = state.batches;
    state = DeckListLoaded(
      batches: {
        for (final e in batches.entries)
          if (e.key != batches.keys.last) e.key: e.value
      },
      hasMore: true,
      hasLess: batches.length > 2,
    );
  }

  void dispose() {
    for (final s in _subscriptions) {
      s.close();
    }
  }
}

typedef BatchId = int;

extension SessionToDeckPreview on SessionDto {
  DeckPreview toDeckPreview() {
    final name = _getName(input);
    if (error != null) {
      return DeckPreview.error(
        createdAt: createdAt,
        message: error!,
        name: name,
        numberOfCards: numberOfCards,
        sessionId: id,
        model: model,
      );
    }

    if (status == SessionStatus.running) {
      return DeckPreview.loading(
        createdAt: createdAt,
        name: name,
        numberOfCards: numberOfCards,
        sessionId: id,
        model: model,
      );
    }

    final questions = (cards?.values.map((c) => c.question).toList() ?? [])
      ..sort();
    return DeckPreview.created(
      createdAt: createdAt,
      name: name,
      numberOfCards: cards?.length ?? 0,
      questions: questions.length < 5 ? questions : questions.sublist(0, 5),
      sessionId: id,
      model: model,
    );
  }
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

sealed class DeckListState {
  const DeckListState({
    required this.batches,
  });

  final Map<BatchId, List<DeckPreview>> batches;
  Set<DeckPreview> get decks => batches.values.expand((e) => e).toSet();
  List<DeckPreview> get last => batches.values.last;
}

class DeckListLoading extends DeckListState {
  DeckListLoading({
    required super.batches,
  });
}

class DeckListError extends DeckListState {
  DeckListError({
    required super.batches,
    required this.message,
  });

  final String message;
}

class DeckListLoaded extends DeckListState {
  const DeckListLoaded({
    required super.batches,
    required this.hasMore,
    required this.hasLess,
  });

  final bool hasMore;
  final bool hasLess;
}
