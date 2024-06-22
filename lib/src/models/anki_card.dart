import 'package:ankigpt/src/infrastructure/firestore_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anki_card.freezed.dart';
part 'anki_card.g.dart';

@Freezed(fromJson: true, toStringOverride: false)
class AnkiCard with _$AnkiCard {
  const AnkiCard._();

  const factory AnkiCard({
    required String id,
    @JsonKey(fromJson: parseString) required String question,
    @JsonKey(fromJson: parseString) required String answer,
    @JsonKey(fromJson: parseTimestampOrIsoString) required DateTime createdAt,
    @Default(false) bool hasLiked,
    @Default(false) bool hasDisliked,

    /// The information of the job that created this card.
    ///
    /// This feature was added on 8. August 2023. Cards created before that
    /// date will have a null value for this field.
    Job? job,
  }) = _AnkiCard;

  factory AnkiCard.fromJson(Map<String, dynamic> json) =>
      _$AnkiCardFromJson(json);

  factory AnkiCard.fromJsonInjection(
    String id,
    Map<String, dynamic> json, {
    int? jobIndex,
  }) {
    json['id'] = id;

    if (json['editedAnswer'] != null) {
      json['answer'] = json['editedAnswer'];
    }

    if (json['editedQuestion'] != null) {
      json['question'] = json['editedQuestion'];
    }

    return AnkiCard.fromJson(json);
  }

  @override
  String toString() {
    final shortQuestion =
        question.length > 20 ? '${question.substring(0, 20)}...' : question;

    final shortAnswer =
        answer.length > 20 ? '${answer.substring(0, 20)}...' : answer;

    return 'AnkiCard(id: $id, question: $shortQuestion, answer: $shortAnswer, createdAt: $createdAt, hasLiked: $hasLiked, hasDisliked: $hasDisliked)';
  }
}

@Freezed(fromJson: true)
class Job with _$Job {
  const factory Job({
    required String id,
    required int index,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}

/// Parses an object to a string.
///
/// Sometimes there was a problem that an answer was just an integer and it was
/// stored as int (instead of a string)
String parseString(dynamic text) {
  return '$text';
}
