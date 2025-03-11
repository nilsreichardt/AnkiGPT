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
      deleteUserSchedule: json['deleteUserSchedule'] == null
          ? null
          : DeleteUserSchedule.fromJson(
              json['deleteUserSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'hasPlus': instance.hasPlus,
      'usage': instance.usage.toJson(),
      'deleteUserSchedule': instance.deleteUserSchedule?.toJson(),
    };

_$UsageImpl _$$UsageImplFromJson(Map<String, dynamic> json) => _$UsageImpl(
      generatedCardsCurrentMonth:
          (json['generatedCardsCurrentMonth'] as num?)?.toInt() ?? 0,
      generatedMnemonicsCurrentMonth:
          (json['generatedMnemonicsCurrentMonth'] as num?)?.toInt() ?? 0,
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
      gpt4: (json['gpt-4o'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UsagePerMonthPerModelImplToJson(
        _$UsagePerMonthPerModelImpl instance) =>
    <String, dynamic>{
      'gpt-4o': instance.gpt4,
    };

_$DeleteUserScheduleImpl _$$DeleteUserScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$DeleteUserScheduleImpl(
      id: json['id'] as String,
    );

Map<String, dynamic> _$$DeleteUserScheduleImplToJson(
        _$DeleteUserScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
