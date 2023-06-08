import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/csv_metadata.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_cards_response.freezed.dart';
part 'get_cards_response.g.dart';

@Freezed(
  fromJson: true,
)
class GetCardsResponse with _$GetCardsResponse {
  const factory GetCardsResponse({
    SessionId? sessionId,
    List<AnkiCard>? cards,
    required bool isCompleted,
    CsvMetadata? csv,
    @JsonKey(fromJson: parseError) String? error,
    Language? language,
  }) = _GetCardsResponse;

  factory GetCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCardsResponseFromJson(json);
}

String? parseError(dynamic data) {
  if (data == null) null;

  if (data is Map<String, dynamic>) {
    return data['message'] as String;
  }

  return data;
}
