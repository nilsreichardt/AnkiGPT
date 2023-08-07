// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anki_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnkiCard _$$_AnkiCardFromJson(Map<String, dynamic> json) => _$_AnkiCard(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      createdAt: parseTimestampOrIsoString(json['createdAt']),
      hasLiked: json['hasLiked'] as bool? ?? false,
      hasDisliked: json['hasDisliked'] as bool? ?? false,
      job: json['job'] == null
          ? null
          : Job.fromJson(json['job'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AnkiCardToJson(_$_AnkiCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'createdAt': instance.createdAt.toIso8601String(),
      'hasLiked': instance.hasLiked,
      'hasDisliked': instance.hasDisliked,
      'job': instance.job?.toJson(),
    };

_$_Job _$$_JobFromJson(Map<String, dynamic> json) => _$_Job(
      id: json['id'] as String,
      index: json['index'] as int,
    );

Map<String, dynamic> _$$_JobToJson(_$_Job instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
    };
