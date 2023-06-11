import 'package:ankigpt/src/infrastructure/firestore_utils.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/csv_metadata.dart';
import 'package:ankigpt/src/models/input_type.dart';
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
    required Input input,
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

String? parseError(dynamic data) {
  if (data == null) null;

  if (data is Map<String, dynamic>) {
    return data['message'] as String;
  }

  return data;
}

@Freezed(fromJson: true)
class Input with _$Input {
  const factory Input({
    required String? text,
    required InputType type,
    required FileInput? file,
  }) = _Input;

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);
}

@Freezed(fromJson: true)
class FileInput with _$FileInput {
  const factory FileInput({
    required String name,
  }) = _FileInput;

  factory FileInput.fromJson(Map<String, dynamic> json) =>
      _$FileInputFromJson(json);
}
