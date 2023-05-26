// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anki_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnkiCard _$$_AnkiCardFromJson(Map<String, dynamic> json) => _$_AnkiCard(
      question: json['question'] as String,
      answer: json['answer'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AnkiCardToJson(_$_AnkiCard instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'createdAt': instance.createdAt.toIso8601String(),
    };
