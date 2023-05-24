import 'package:freezed_annotation/freezed_annotation.dart';

part 'anki_card.freezed.dart';

@freezed
class AnkiCard with _$AnkiCard {
  const factory AnkiCard({
    required String front,
    required String back,
  }) = _AnkiCard;
}
