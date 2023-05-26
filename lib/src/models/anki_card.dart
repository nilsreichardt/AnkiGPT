import 'package:freezed_annotation/freezed_annotation.dart';

part 'anki_card.freezed.dart';
part 'anki_card.g.dart';

@Freezed(fromJson: true)
class AnkiCard with _$AnkiCard {
  const factory AnkiCard({
    required String question,
    required String answer,
    required DateTime createdAt,
  }) = _AnkiCard;

  factory AnkiCard.fromJson(Map<String, dynamic> json) =>
      _$AnkiCardFromJson(json);
}
