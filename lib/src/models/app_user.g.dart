// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      hasPlus: json['hasPlus'] as bool? ?? false,
      usage: json['usage'] == null
          ? const Usage(
              generatedCardsCurrentMonth: 0,
              generatedMnemonicsCurrentMonth: 0,
              generatedCardsWithGpt4CurrentMonth: 0)
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'hasPlus': instance.hasPlus,
      'usage': instance.usage.toJson(),
    };

_$UsageImpl _$$UsageImplFromJson(Map<String, dynamic> json) => _$UsageImpl(
      generatedCardsCurrentMonth:
          json['generatedCardsCurrentMonth'] as int? ?? 0,
      generatedMnemonicsCurrentMonth:
          json['generatedMnemonicsCurrentMonth'] as int? ?? 0,
      generatedCardsWithGpt4CurrentMonth:
          json['generatedCardsWithGpt4CurrentMonth'] as int? ?? 0,
    );

Map<String, dynamic> _$$UsageImplToJson(_$UsageImpl instance) =>
    <String, dynamic>{
      'generatedCardsCurrentMonth': instance.generatedCardsCurrentMonth,
      'generatedMnemonicsCurrentMonth': instance.generatedMnemonicsCurrentMonth,
      'generatedCardsWithGpt4CurrentMonth':
          instance.generatedCardsWithGpt4CurrentMonth,
    };
