import 'dart:math';

import 'package:ankigpt/src/infrastructure/firestore_utils.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/csv_metadata.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
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
    @JsonKey(fromJson: parseVisibility) required Visibility visibility,
    required UserId userId,
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

Visibility parseVisibility(Map<String, dynamic>? json) {
  const defaultValue = Visibility.private;

  if (json == null) {
    return defaultValue;
  }

  final value = json['value'];
  if (value is! String?) {
    return defaultValue;
  }

  return Visibility.values.tryByName(json['value']);
}

extension EnumByNameWithDefault<T extends Enum> on Iterable<T> {
  T tryByName(String? name, {T? defaultValue}) {
    for (T value in this) {
      if (value.name == name) return value;
    }

    if (defaultValue != null) return defaultValue;
    throw ArgumentError.value(name, "name", "No enum value with that name");
  }

  T? byNameOrNull(String? name) {
    for (T value in this) {
      if (value.name == name) return value;
    }

    return null;
  }
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
    String? pdfPassword,
  }) = _FileInput;

  factory FileInput.fromJson(Map<String, dynamic> json) =>
      _$FileInputFromJson(json);
}
