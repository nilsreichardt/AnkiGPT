// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anki_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnkiCard _$$_AnkiCardFromJson(Map<String, dynamic> json) => _$_AnkiCard(
      front: json['front'] as String,
      back: json['back'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AnkiCardToJson(_$_AnkiCard instance) =>
    <String, dynamic>{
      'front': instance.front,
      'back': instance.back,
      'createdAt': instance.createdAt.toIso8601String(),
    };
