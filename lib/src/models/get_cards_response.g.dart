// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetCardsResponse _$$_GetCardsResponseFromJson(Map<String, dynamic> json) =>
    _$_GetCardsResponse(
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => AnkiCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool,
      csv: json['csv'] == null
          ? null
          : CsvMetadata.fromJson(json['csv'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$_GetCardsResponseToJson(_$_GetCardsResponse instance) =>
    <String, dynamic>{
      'cards': instance.cards,
      'isCompleted': instance.isCompleted,
      'csv': instance.csv,
      'error': instance.error,
    };
