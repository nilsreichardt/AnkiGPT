import 'package:ankigpt/src/infrastructure/firestore_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'anki_card.freezed.dart';
part 'anki_card.g.dart';

@Freezed(fromJson: true)
class AnkiCard with _$AnkiCard {
  const factory AnkiCard({
    required String id,
    required String question,
    required String answer,
    @JsonKey(fromJson: parseTimestampOrIsoString) required DateTime createdAt,
    @Default(false) bool hasLiked,
    @Default(false) bool hasDisliked,
  }) = _AnkiCard;

  factory AnkiCard.fromJson(Map<String, dynamic> json) =>
      _$AnkiCardFromJson(json);

  factory AnkiCard.fromJsonInjection(String id, Map<String, dynamic> json) {
    json['id'] = id;

    if (json['editedAnswer'] != null) {
      json['answer'] = json['editedAnswer'];
    }

    if (json['editedQuestion'] != null) {
      json['question'] = json['editedQuestion'];
    }

    return AnkiCard.fromJson(json);
  }
}
