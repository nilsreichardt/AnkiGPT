import 'package:ankigpt/src/models/session_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_deck.freezed.dart';

@freezed
class HistoryDeck with _$HistoryDeck {
  const factory HistoryDeck.created({
    required List<String> questions,
    required DateTime createdAt,
    required String name,
    required SessionDto sessionDto,
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
