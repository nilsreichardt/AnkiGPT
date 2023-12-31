// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionDtoImpl _$$SessionDtoImplFromJson(Map<String, dynamic> json) =>
    _$SessionDtoImpl(
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
      visibility: parseVisibility(json['visibility'] as Map<String, dynamic>?),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$SessionDtoImplToJson(_$SessionDtoImpl instance) =>
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
      'visibility': _$VisibilityEnumMap[instance.visibility]!,
      'userId': instance.userId,
    };

const _$LanguageEnumMap = {
  Language.af: 'af',
  Language.sq: 'sq',
  Language.am: 'am',
  Language.ar: 'ar',
  Language.hy: 'hy',
  Language.as: 'as',
  Language.ay: 'ay',
  Language.az: 'az',
  Language.bm: 'bm',
  Language.eu: 'eu',
  Language.be: 'be',
  Language.bn: 'bn',
  Language.bho: 'bho',
  Language.bs: 'bs',
  Language.bg: 'bg',
  Language.ca: 'ca',
  Language.ceb: 'ceb',
  Language.ny: 'ny',
  Language.zh: 'zh',
  Language.zhTW: 'zhTW',
  Language.co: 'co',
  Language.hr: 'hr',
  Language.cs: 'cs',
  Language.da: 'da',
  Language.dv: 'dv',
  Language.doi: 'doi',
  Language.nl: 'nl',
  Language.en: 'en',
  Language.eo: 'eo',
  Language.et: 'et',
  Language.ee: 'ee',
  Language.tl: 'tl',
  Language.fi: 'fi',
  Language.fr: 'fr',
  Language.fy: 'fy',
  Language.gl: 'gl',
  Language.lg: 'lg',
  Language.ka: 'ka',
  Language.de: 'de',
  Language.el: 'el',
  Language.gn: 'gn',
  Language.gu: 'gu',
  Language.ht: 'ht',
  Language.ha: 'ha',
  Language.haw: 'haw',
  Language.iw: 'iw',
  Language.hi: 'hi',
  Language.hmn: 'hmn',
  Language.hu: 'hu',
  Language.is_: 'is_',
  Language.ig: 'ig',
  Language.ilo: 'ilo',
  Language.id: 'id',
  Language.ga: 'ga',
  Language.it: 'it',
  Language.ja: 'ja',
  Language.jw: 'jw',
  Language.kn: 'kn',
  Language.kk: 'kk',
  Language.km: 'km',
  Language.rw: 'rw',
  Language.gom: 'gom',
  Language.ko: 'ko',
  Language.kri: 'kri',
  Language.ku: 'ku',
  Language.ckb: 'ckb',
  Language.ky: 'ky',
  Language.lo: 'lo',
  Language.la: 'la',
  Language.lv: 'lv',
  Language.ln: 'ln',
  Language.lt: 'lt',
  Language.lb: 'lb',
  Language.mk: 'mk',
  Language.mai: 'mai',
  Language.mg: 'mg',
  Language.ms: 'ms',
  Language.ml: 'ml',
  Language.mt: 'mt',
  Language.mi: 'mi',
  Language.mr: 'mr',
  Language.mniMtei: 'mniMtei',
  Language.lus: 'lus',
  Language.mn: 'mn',
  Language.my: 'my',
  Language.ne: 'ne',
  Language.nso: 'nso',
  Language.no: 'no',
  Language.or: 'or',
  Language.om: 'om',
  Language.ps: 'ps',
  Language.fa: 'fa',
  Language.pl: 'pl',
  Language.pt: 'pt',
  Language.pa: 'pa',
  Language.qu: 'qu',
  Language.ro: 'ro',
  Language.ru: 'ru',
  Language.sm: 'sm',
  Language.sa: 'sa',
  Language.gd: 'gd',
  Language.sr: 'sr',
  Language.st: 'st',
  Language.sn: 'sn',
  Language.sd: 'sd',
  Language.si: 'si',
  Language.sk: 'sk',
  Language.sl: 'sl',
  Language.so: 'so',
  Language.es: 'es',
  Language.su: 'su',
  Language.sw: 'sw',
  Language.sv: 'sv',
  Language.tg: 'tg',
  Language.ta: 'ta',
  Language.tt: 'tt',
  Language.te: 'te',
  Language.th: 'th',
  Language.ti: 'ti',
  Language.ts: 'ts',
  Language.tr: 'tr',
  Language.tk: 'tk',
  Language.ak: 'ak',
  Language.uk: 'uk',
  Language.ur: 'ur',
  Language.ug: 'ug',
  Language.uz: 'uz',
  Language.vi: 'vi',
  Language.cy: 'cy',
  Language.xh: 'xh',
  Language.yi: 'yi',
  Language.yo: 'yo',
  Language.zu: 'zu',
  Language.he: 'he',
  Language.jv: 'jv',
  Language.zhCN: 'zhCN',
  Language.unknown: 'unknown',
};

const _$SessionStatusEnumMap = {
  SessionStatus.running: 'running',
  SessionStatus.error: 'error',
  SessionStatus.completed: 'completed',
  SessionStatus.stopped: 'stopped',
};

const _$VisibilityEnumMap = {
  Visibility.private: 'private',
  Visibility.anyoneWithLink: 'anyoneWithLink',
};

_$InputImpl _$$InputImplFromJson(Map<String, dynamic> json) => _$InputImpl(
      text: json['text'] as String?,
      type: $enumDecode(_$InputTypeEnumMap, json['type']),
      file: json['file'] == null
          ? null
          : FileInput.fromJson(json['file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InputImplToJson(_$InputImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': _$InputTypeEnumMap[instance.type]!,
      'file': instance.file?.toJson(),
    };

const _$InputTypeEnumMap = {
  InputType.text: 'text',
  InputType.file: 'file',
};

_$FileInputImpl _$$FileInputImplFromJson(Map<String, dynamic> json) =>
    _$FileInputImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$FileInputImplToJson(_$FileInputImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
