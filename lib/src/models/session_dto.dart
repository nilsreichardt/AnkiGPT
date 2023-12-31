import 'dart:math';

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
    required SessionStatus status,
    @JsonKey(fromJson: parseError) String? error,
    required int numberOfCards,
    @JsonKey(
      unknownEnumValue: Visibility.private,
      defaultValue: Visibility.private,
    )
    required Visibility visibility,
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
  return (json
        ..removeWhere((key, value) {
          final data = value as Map<String, dynamic>;
          return data['isDeleted'] == true;
        }))
      .map(
    (k, e) => MapEntry(
      k,
      AnkiCard.fromJsonInjection(k, e as Map<String, dynamic>),
    ),
  );
}

String? parseError(dynamic data) {
  if (data == null) null;

  if (data is Map<String, dynamic>) {
    return data['message'] as String;
  }

  return data;
}

enum SessionStatus {
  running,
  error,
  completed,
  stopped,
}

enum Visibility {
  private,
  anyoneWithLink,
}

@Freezed(fromJson: true, toStringOverride: false)
class Input with _$Input {
  const Input._();

  const factory Input({
    required String? text,
    required InputType type,
    required FileInput? file,
  }) = _Input;

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  @override
  String toString() {
    final shortText =
        text == null ? null : '${text!.substring(0, min(20, text!.length))}...';
    return 'Input(text: $shortText, type: $type, file: $file)';
  }
}

@Freezed(fromJson: true)
class FileInput with _$FileInput {
  const factory FileInput({
    required String name,
  }) = _FileInput;

  factory FileInput.fromJson(Map<String, dynamic> json) =>
      _$FileInputFromJson(json);
}
