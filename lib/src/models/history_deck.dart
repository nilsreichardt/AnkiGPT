import 'package:ankigpt/src/models/session_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_deck.freezed.dart';

@freezed
class HistoryDeck with _$HistoryDeck {
  const factory HistoryDeck.created({
    required List<String> questions,
    required DateTime createdAt,
    required String name,
    required SessionId sessionId,
    required int numberOfCards,
  }) = HistoryDeckCreated;
  const factory HistoryDeck.loading({
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
  }) = HistoryDeckLoading;
  const factory HistoryDeck.error({
    required String message,
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
  }) = HistoryDeckError;
}
