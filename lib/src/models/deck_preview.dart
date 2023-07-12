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
    required int numberOfCards,
  }) = DeckPreviewCreated;
  const factory DeckPreview.loading({
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
  }) = DeckPreviewLoading;
  const factory DeckPreview.error({
    required String message,
    required DateTime createdAt,
    required String name,
    required int numberOfCards,
  }) = DeckPreviewError;
}
