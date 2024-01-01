import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck_preview.freezed.dart';

@freezed
class DeckPreview with _$DeckPreview {
  const factory DeckPreview.created({
    required List<String> questions,
    required DateTime createdAt,
    required String name,
    required SessionId sessionId,
    required Model model,
    required int numberOfCards,
  }) = DeckPreviewCreated;
  const factory DeckPreview.loading({
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
    required SessionId sessionId,
    required Model model,
  }) = DeckPreviewLoading;
  const factory DeckPreview.error({
    required String message,
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
    required SessionId sessionId,
    required Model model,
  }) = DeckPreviewError;
}
