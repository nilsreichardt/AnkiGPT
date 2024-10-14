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
      numberOfCards: (json['numberOfCards'] as num).toInt(),
      visibility: parseVisibility(json['visibility'] as Map<String, dynamic>?),
      userId: json['userId'] as String,
      model: parseModel(json['model'] as Map<String, dynamic>?),
      title: json['title'] as String?,
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
      'model': _$ModelEnumMap[instance.model]!,
      'title': instance.title,
    };

const _$LanguageEnumMap = {
  Language.aa: 'aa',
  Language.ab: 'ab',
  Language.ace: 'ace',
  Language.ach: 'ach',
  Language.af: 'af',
  Language.ak: 'ak',
  Language.alz: 'alz',
  Language.am: 'am',
  Language.ar: 'ar',
  Language.as: 'as',
  Language.av: 'av',
  Language.awa: 'awa',
  Language.ay: 'ay',
  Language.az: 'az',
  Language.ba: 'ba',
  Language.bal: 'bal',
  Language.ban: 'ban',
  Language.bbc: 'bbc',
  Language.bci: 'bci',
  Language.be: 'be',
  Language.bem: 'bem',
  Language.ber: 'ber',
  Language.berLatn: 'berLatn',
  Language.bew: 'bew',
  Language.bg: 'bg',
  Language.bho: 'bho',
  Language.bik: 'bik',
  Language.bm: 'bm',
  Language.bmNkoo: 'bmNkoo',
  Language.bn: 'bn',
  Language.bo: 'bo',
  Language.br: 'br',
  Language.bs: 'bs',
  Language.bts: 'bts',
  Language.btx: 'btx',
  Language.bua: 'bua',
  Language.ca: 'ca',
  Language.ce: 'ce',
  Language.ceb: 'ceb',
  Language.cgg: 'cgg',
  Language.ch: 'ch',
  Language.chk: 'chk',
  Language.chm: 'chm',
  Language.ckb: 'ckb',
  Language.cnh: 'cnh',
  Language.co: 'co',
  Language.crh: 'crh',
  Language.crs: 'crs',
  Language.cs: 'cs',
  Language.cv: 'cv',
  Language.cy: 'cy',
  Language.da: 'da',
  Language.de: 'de',
  Language.din: 'din',
  Language.doi: 'doi',
  Language.dov: 'dov',
  Language.dv: 'dv',
  Language.dyu: 'dyu',
  Language.dz: 'dz',
  Language.ee: 'ee',
  Language.el: 'el',
  Language.en: 'en',
  Language.eo: 'eo',
  Language.es: 'es',
  Language.et: 'et',
  Language.eu: 'eu',
  Language.fa: 'fa',
  Language.faAF: 'faAF',
  Language.ff: 'ff',
  Language.fi: 'fi',
  Language.fj: 'fj',
  Language.fo: 'fo',
  Language.fon: 'fon',
  Language.fr: 'fr',
  Language.fur: 'fur',
  Language.fy: 'fy',
  Language.ga: 'ga',
  Language.gaa: 'gaa',
  Language.gd: 'gd',
  Language.gl: 'gl',
  Language.gn: 'gn',
  Language.gom: 'gom',
  Language.gu: 'gu',
  Language.gv: 'gv',
  Language.ha: 'ha',
  Language.haw: 'haw',
  Language.he: 'he',
  Language.hi: 'hi',
  Language.hil: 'hil',
  Language.hmn: 'hmn',
  Language.hr: 'hr',
  Language.hrx: 'hrx',
  Language.ht: 'ht',
  Language.hu: 'hu',
  Language.hy: 'hy',
  Language.iba: 'iba',
  Language.id: 'id',
  Language.ig: 'ig',
  Language.ilo: 'ilo',
  Language.is_: 'is_',
  Language.it: 'it',
  Language.iw: 'iw',
  Language.ja: 'ja',
  Language.jam: 'jam',
  Language.jv: 'jv',
  Language.jw: 'jw',
  Language.ka: 'ka',
  Language.kac: 'kac',
  Language.kek: 'kek',
  Language.kg: 'kg',
  Language.kha: 'kha',
  Language.kk: 'kk',
  Language.kl: 'kl',
  Language.km: 'km',
  Language.kn: 'kn',
  Language.ko: 'ko',
  Language.kr: 'kr',
  Language.kri: 'kri',
  Language.ktu: 'ktu',
  Language.ku: 'ku',
  Language.kv: 'kv',
  Language.ky: 'ky',
  Language.la: 'la',
  Language.lb: 'lb',
  Language.lg: 'lg',
  Language.li: 'li',
  Language.lij: 'lij',
  Language.lmo: 'lmo',
  Language.ln: 'ln',
  Language.lo: 'lo',
  Language.lt: 'lt',
  Language.ltg: 'ltg',
  Language.luo: 'luo',
  Language.lus: 'lus',
  Language.lv: 'lv',
  Language.mad: 'mad',
  Language.mai: 'mai',
  Language.mak: 'mak',
  Language.mam: 'mam',
  Language.mfe: 'mfe',
  Language.mg: 'mg',
  Language.mh: 'mh',
  Language.mi: 'mi',
  Language.min: 'min',
  Language.mk: 'mk',
  Language.ml: 'ml',
  Language.mn: 'mn',
  Language.mniMtei: 'mniMtei',
  Language.mr: 'mr',
  Language.ms: 'ms',
  Language.msArab: 'msArab',
  Language.mt: 'mt',
  Language.mwr: 'mwr',
  Language.my: 'my',
  Language.ndcZW: 'ndcZW',
  Language.ne: 'ne',
  Language.new_: 'new_',
  Language.nhe: 'nhe',
  Language.nl: 'nl',
  Language.no: 'no',
  Language.nr: 'nr',
  Language.nso: 'nso',
  Language.nus: 'nus',
  Language.ny: 'ny',
  Language.oc: 'oc',
  Language.om: 'om',
  Language.or: 'or',
  Language.os: 'os',
  Language.pa: 'pa',
  Language.paArab: 'paArab',
  Language.pag: 'pag',
  Language.pam: 'pam',
  Language.pap: 'pap',
  Language.pl: 'pl',
  Language.ps: 'ps',
  Language.pt: 'pt',
  Language.ptPT: 'ptPT',
  Language.qu: 'qu',
  Language.rn: 'rn',
  Language.ro: 'ro',
  Language.rom: 'rom',
  Language.ru: 'ru',
  Language.rw: 'rw',
  Language.sa: 'sa',
  Language.sah: 'sah',
  Language.satLatn: 'satLatn',
  Language.scn: 'scn',
  Language.sd: 'sd',
  Language.se: 'se',
  Language.sg: 'sg',
  Language.shn: 'shn',
  Language.si: 'si',
  Language.sk: 'sk',
  Language.sl: 'sl',
  Language.sm: 'sm',
  Language.sn: 'sn',
  Language.so: 'so',
  Language.sq: 'sq',
  Language.sr: 'sr',
  Language.ss: 'ss',
  Language.st: 'st',
  Language.su: 'su',
  Language.sus: 'sus',
  Language.sv: 'sv',
  Language.sw: 'sw',
  Language.szl: 'szl',
  Language.ta: 'ta',
  Language.tcy: 'tcy',
  Language.te: 'te',
  Language.tet: 'tet',
  Language.tg: 'tg',
  Language.th: 'th',
  Language.ti: 'ti',
  Language.tiv: 'tiv',
  Language.tk: 'tk',
  Language.tl: 'tl',
  Language.tn: 'tn',
  Language.to: 'to',
  Language.tpi: 'tpi',
  Language.tr: 'tr',
  Language.trp: 'trp',
  Language.ts: 'ts',
  Language.tt: 'tt',
  Language.tum: 'tum',
  Language.ty: 'ty',
  Language.tyv: 'tyv',
  Language.udm: 'udm',
  Language.ug: 'ug',
  Language.uk: 'uk',
  Language.ur: 'ur',
  Language.uz: 'uz',
  Language.ve: 've',
  Language.vec: 'vec',
  Language.vi: 'vi',
  Language.war: 'war',
  Language.wo: 'wo',
  Language.xh: 'xh',
  Language.yi: 'yi',
  Language.yo: 'yo',
  Language.yua: 'yua',
  Language.yue: 'yue',
  Language.zap: 'zap',
  Language.zh: 'zh',
  Language.zhCN: 'zhCN',
  Language.zhTW: 'zhTW',
  Language.zu: 'zu',
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

const _$ModelEnumMap = {
  Model.gpt3_5: 'gpt3_5',
  Model.gpt4: 'gpt4',
  Model.gpt4o_mini: 'gpt4o_mini',
  Model.gpt4o: 'gpt4o',
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
      pdfPassword: json['pdfPassword'] as String?,
    );

Map<String, dynamic> _$$FileInputImplToJson(_$FileInputImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pdfPassword': instance.pdfPassword,
    };
