import 'package:ankigpt/src/infrastructure/firestore_utils.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/csv_metadata.dart';
import 'package:ankigpt/src/models/get_cards_response.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_dto.freezed.dart';
part 'session_dto.g.dart';

@Freezed(fromJson: true)
class SessionDto with _$SessionDto {
  const factory SessionDto({
    required String id,
    required Language? language,
    required String slideContent,
    @JsonKey(fromJson: parseTimestamp) required DateTime createdAt,
    required CsvMetadata? csv,
    @JsonKey(fromJson: parseCards) required Map<String, AnkiCard>? cards,
    @Default(false) bool isCompleted,
    @JsonKey(fromJson: parseError) String? error,
    required int numberOfCards,
  }) = _SessionDto;

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);

  factory SessionDto.fromJsonWithInjectedId(
    SessionId sessionId,
    Map<String, dynamic> json,
  ) {
    json['id'] = sessionId;
    return SessionDto.fromJson(json);
  }
}

Map<String, AnkiCard>? parseCards(Map<String, dynamic>? json) {
  if (json == null) return null;
  return json.map(
    (k, e) =>
        MapEntry(k, AnkiCard.fromJsonInjectedId(k, e as Map<String, dynamic>)),
  );
}
