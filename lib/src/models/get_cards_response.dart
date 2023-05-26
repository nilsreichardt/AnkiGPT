import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/csv_metadata.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cards_response.freezed.dart';
part 'get_cards_response.g.dart';

@Freezed(
  fromJson: true,
)
class GetCardsResponse with _$GetCardsResponse {
  const factory GetCardsResponse({
    List<AnkiCard>? cards,
    required bool isCompleted,
    CsvMetadata? csv,
    String? error,
    Language? language,
  }) = _GetCardsResponse;

  factory GetCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCardsResponseFromJson(json);
}
