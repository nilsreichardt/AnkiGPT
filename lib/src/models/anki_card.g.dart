// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anki_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnkiCardImpl _$$AnkiCardImplFromJson(Map<String, dynamic> json) =>
    _$AnkiCardImpl(
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

Map<String, dynamic> _$$AnkiCardImplToJson(_$AnkiCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'createdAt': instance.createdAt.toIso8601String(),
      'hasLiked': instance.hasLiked,
      'hasDisliked': instance.hasDisliked,
      'job': instance.job?.toJson(),
    };

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
    );

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
    };
