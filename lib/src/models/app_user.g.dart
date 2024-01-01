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
              generatedCardsCurrentMonthByModel: UsagePerMonthPerModel())
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
      generatedCardsCurrentMonthByModel:
          json['generatedCardsCurrentMonthByModel'] == null
              ? const UsagePerMonthPerModel()
              : UsagePerMonthPerModel.fromJson(
                  json['generatedCardsCurrentMonthByModel']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UsageImplToJson(_$UsageImpl instance) =>
    <String, dynamic>{
      'generatedCardsCurrentMonth': instance.generatedCardsCurrentMonth,
      'generatedMnemonicsCurrentMonth': instance.generatedMnemonicsCurrentMonth,
      'generatedCardsCurrentMonthByModel':
          instance.generatedCardsCurrentMonthByModel.toJson(),
    };

_$UsagePerMonthPerModelImpl _$$UsagePerMonthPerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UsagePerMonthPerModelImpl(
      gpt4_1106Preview: json['gpt-4-1106-preview'] as int? ?? 0,
    );

Map<String, dynamic> _$$UsagePerMonthPerModelImplToJson(
        _$UsagePerMonthPerModelImpl instance) =>
    <String, dynamic>{
      'gpt-4-1106-preview': instance.gpt4_1106Preview,
    };
