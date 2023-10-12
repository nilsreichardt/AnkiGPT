// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      hasPlus: json['hasPlus'] as bool? ?? false,
      usage: json['usage'] == null
          ? const Usage(generatedCardsCurrentMonth: 0)
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'hasPlus': instance.hasPlus,
      'usage': instance.usage.toJson(),
    };

_$_Usage _$$_UsageFromJson(Map<String, dynamic> json) => _$_Usage(
      generatedCardsCurrentMonth:
          json['generatedCardsCurrentMonth'] as int? ?? 0,
    );

Map<String, dynamic> _$$_UsageToJson(_$_Usage instance) => <String, dynamic>{
      'generatedCardsCurrentMonth': instance.generatedCardsCurrentMonth,
    };
