// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionDto _$$_SessionDtoFromJson(Map<String, dynamic> json) =>
    _$_SessionDto(
      id: json['id'] as String,
      language: $enumDecodeNullable(_$LanguageEnumMap, json['language']),
      input: Input.fromJson(json['input'] as Map<String, dynamic>),
      createdAt: parseTimestamp(json['createdAt'] as Timestamp),
      csv: json['csv'] == null
          ? null
          : CsvMetadata.fromJson(json['csv'] as Map<String, dynamic>),
      cards: parseCards(json['cards'] as Map<String, dynamic>?),
      status: $enumDecode(_$SessionStatusEnumMap, json['status']),
      error: parseError(json['error']),
      numberOfCards: json['numberOfCards'] as int,
    );

Map<String, dynamic> _$$_SessionDtoToJson(_$_SessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': _$LanguageEnumMap[instance.language],
      'input': instance.input.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
      'csv': instance.csv?.toJson(),
      'cards': instance.cards?.map((k, e) => MapEntry(k, e.toJson())),
      'status': _$SessionStatusEnumMap[instance.status]!,
      'error': instance.error,
      'numberOfCards': instance.numberOfCards,
    };

const _$LanguageEnumMap = {
  Language.af: 'af',
  Language.sq: 'sq',
  Language.am: 'am',
  Language.ar: 'ar',
  Language.hy: 'hy',
  Language.as: 'as',
  Language.az: 'az',
  Language.eu: 'eu',
  Language.be: 'be',
  Language.bn: 'bn',
  Language.bs: 'bs',
  Language.bg: 'bg',
  Language.my: 'my',
  Language.ca: 'ca',
  Language.zh: 'zh',
  Language.hr: 'hr',
  Language.cs: 'cs',
  Language.da: 'da',
  Language.nl: 'nl',
  Language.en: 'en',
  Language.et: 'et',
  Language.fa: 'fa',
  Language.fi: 'fi',
  Language.fr: 'fr',
  Language.gl: 'gl',
  Language.ka: 'ka',
  Language.de: 'de',
  Language.el: 'el',
  Language.gu: 'gu',
  Language.ht: 'ht',
  Language.he: 'he',
  Language.hi: 'hi',
  Language.hu: 'hu',
  Language.id: 'id',
  Language.ga: 'ga',
  Language.it: 'it',
  Language.ja: 'ja',
  Language.kn: 'kn',
  Language.kk: 'kk',
  Language.km: 'km',
  Language.ko: 'ko',
  Language.ku: 'ku',
  Language.ky: 'ky',
  Language.lo: 'lo',
  Language.lv: 'lv',
  Language.lt: 'lt',
  Language.lb: 'lb',
  Language.mk: 'mk',
  Language.mg: 'mg',
  Language.ms: 'ms',
  Language.ml: 'ml',
  Language.mt: 'mt',
  Language.mr: 'mr',
  Language.mn: 'mn',
  Language.ne: 'ne',
  Language.no: 'no',
  Language.oc: 'oc',
  Language.or: 'or',
  Language.ps: 'ps',
  Language.pl: 'pl',
  Language.pt: 'pt',
  Language.pa: 'pa',
  Language.ro: 'ro',
  Language.ru: 'ru',
  Language.sm: 'sm',
  Language.gd: 'gd',
  Language.sr: 'sr',
  Language.sd: 'sd',
  Language.si: 'si',
  Language.sk: 'sk',
  Language.sl: 'sl',
  Language.so: 'so',
  Language.st: 'st',
  Language.es: 'es',
  Language.sw: 'sw',
  Language.sv: 'sv',
  Language.tl: 'tl',
  Language.tg: 'tg',
  Language.ta: 'ta',
  Language.te: 'te',
  Language.th: 'th',
  Language.tr: 'tr',
  Language.tk: 'tk',
  Language.uk: 'uk',
  Language.ur: 'ur',
  Language.ug: 'ug',
  Language.uz: 'uz',
  Language.vi: 'vi',
  Language.cy: 'cy',
  Language.fy: 'fy',
  Language.xh: 'xh',
  Language.yi: 'yi',
  Language.yo: 'yo',
  Language.zu: 'zu',
  Language.unknown: 'unknown',
};

const _$SessionStatusEnumMap = {
  SessionStatus.running: 'running',
  SessionStatus.error: 'error',
  SessionStatus.completed: 'completed',
  SessionStatus.stopped: 'stopped',
};

_$_Input _$$_InputFromJson(Map<String, dynamic> json) => _$_Input(
      text: json['text'] as String?,
      type: $enumDecode(_$InputTypeEnumMap, json['type']),
      file: json['file'] == null
          ? null
          : FileInput.fromJson(json['file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_InputToJson(_$_Input instance) => <String, dynamic>{
      'text': instance.text,
      'type': _$InputTypeEnumMap[instance.type]!,
      'file': instance.file?.toJson(),
    };

const _$InputTypeEnumMap = {
  InputType.text: 'text',
  InputType.file: 'file',
};

_$_FileInput _$$_FileInputFromJson(Map<String, dynamic> json) => _$_FileInput(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_FileInputToJson(_$_FileInput instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
