/// Enum representing various languages using ISO 639-1 language codes.
///
/// The [Language] enum provides a list of languages with their corresponding ISO 639-1 language codes. These codes can
/// be used to identify specific languages or group similar languages together.
///
/// See: https://en.wikipedia.org/wiki/ISO_639
enum Language {
  af, // Afrikaans
  sq, // Albanian
  am, // Amharic
  ar, // Arabic
  hy, // Armenian
  as, // Assamese
  ay, // Aymara
  az, // Azerbaijani
  bm, // Bambara
  eu, // Basque
  be, // Belarusian
  bn, // Bengali
  bho, // Bhojpuri
  bs, // Bosnian
  bg, // Bulgarian
  ca, // Catalan
  ceb, // Cebuano
  ny, // Chichewa
  zh, // Chinese (Simplified)
  zhTW, // Chinese (Traditional)
  co, // Corsican
  hr, // Croatian
  cs, // Czech
  da, // Danish
  dv, // Divehi
  doi, // Dogri
  nl, // Dutch
  en, // English
  eo, // Esperanto
  et, // Estonian
  ee, // Ewe
  tl, // Filipino
  fi, // Finnish
  fr, // French
  fy, // Frisian
  gl, // Galician
  lg, // Ganda
  ka, // Georgian
  de, // German
  el, // Greek
  gn, // Guarani
  gu, // Gujarati
  ht, // Haitian Creole
  ha, // Hausa
  haw, // Hawaiian
  iw, // Hebrew
  hi, // Hindi
  hmn, // Hmong
  hu, // Hungarian
  is_, // Icelandic
  ig, // Igbo
  ilo, // Iloko
  id, // Indonesian
  ga, // Irish Gaelic
  it, // Italian
  ja, // Japanese
  jw, // Javanese
  kn, // Kannada
  kk, // Kazakh
  km, // Khmer
  rw, // Kinyarwanda
  gom, // Konkani
  ko, // Korean
  kri, // Krio
  ku, // Kurdish (Kurmanji)
  ckb, // Kurdish (Sorani)
  ky, // Kyrgyz
  lo, // Lao
  la, // Latin
  lv, // Latvian
  ln, // Lingala
  lt, // Lithuanian
  lb, // Luxembourgish
  mk, // Macedonian
  mai, // Maithili
  mg, // Malagasy
  ms, // Malay
  ml, // Malayalam
  mt, // Maltese
  mi, // Maori
  mr, // Marathi
  mniMtei, // Meiteilon (Manipuri)
  lus, // Mizo
  mn, // Mongolian
  my, // Myanmar (Burmese)
  ne, // Nepali
  nso, // Northern Sotho
  no, // Norwegian
  or, // Odia (Oriya)
  om, // Oromo
  ps, // Pashto
  fa, // Persian
  pl, // Polish
  pt, // Portuguese
  pa, // Punjabi
  qu, // Quechua
  ro, // Romanian
  ru, // Russian
  sm, // Samoan
  sa, // Sanskrit
  gd, // Scots Gaelic
  sr, // Serbian
  st, // Sesotho
  sn, // Shona
  sd, // Sindhi
  si, // Sinhala
  sk, // Slovak
  sl, // Slovenian
  so, // Somali
  es, // Spanish
  su, // Sundanese
  sw, // Swahili
  sv, // Swedish
  tg, // Tajik
  ta, // Tamil
  tt, // Tatar
  te, // Telugu
  th, // Thai
  ti, // Tigrinya
  ts, // Tsonga
  tr, // Turkish
  tk, // Turkmen
  ak, // Twi
  uk, // Ukrainian
  ur, // Urdu
  ug, // Uyghur
  uz, // Uzbek
  vi, // Vietnamese
  cy, // Welsh
  xh, // Xhosa
  yi, // Yiddish
  yo, // Yoruba
  zu, // Zulu
  he, // Hebrew
  jv, // Javanese
  zhCN, // Chinese (Simplified)
  unknown; // Unknown

  String getDisplayName() {
    switch (this) {
      case Language.af:
        return 'Afrikaans';
      case Language.sq:
        return 'Albanian';
      case Language.am:
        return 'Amharic';
      case Language.ar:
        return 'Arabic';
      case Language.hy:
        return 'Armenian';
      case Language.as:
        return 'Assamese';
      case Language.ay:
        return 'Aymara';
      case Language.az:
        return 'Azerbaijani';
      case Language.bm:
        return 'Bambara';
      case Language.eu:
        return 'Basque';
      case Language.be:
        return 'Belarusian';
      case Language.bn:
        return 'Bengali';
      case Language.bho:
        return 'Bhojpuri';
      case Language.bs:
        return 'Bosnian';
      case Language.bg:
        return 'Bulgarian';
      case Language.ca:
        return 'Catalan';
      case Language.ceb:
        return 'Cebuano';
      case Language.ny:
        return 'Chichewa';
      case Language.zh:
        return 'Chinese (Simplified)';
      case Language.zhTW:
        return 'Chinese (Traditional)';
      case Language.co:
        return 'Corsican';
      case Language.hr:
        return 'Croatian';
      case Language.cs:
        return 'Czech';
      case Language.da:
        return 'Danish';
      case Language.dv:
        return 'Divehi';
      case Language.doi:
        return 'Dogri';
      case Language.nl:
        return 'Dutch';
      case Language.en:
        return 'English';
      case Language.eo:
        return 'Esperanto';
      case Language.et:
        return 'Estonian';
      case Language.ee:
        return 'Ewe';
      case Language.tl:
        return 'Filipino';
      case Language.fi:
        return 'Finnish';
      case Language.fr:
        return 'French';
      case Language.fy:
        return 'Frisian';
      case Language.gl:
        return 'Galician';
      case Language.lg:
        return 'Ganda';
      case Language.ka:
        return 'Georgian';
      case Language.de:
        return 'German';
      case Language.el:
        return 'Greek';
      case Language.gn:
        return 'Guarani';
      case Language.gu:
        return 'Gujarati';
      case Language.ht:
        return 'Haitian Creole';
      case Language.ha:
        return 'Hausa';
      case Language.haw:
        return 'Hawaiian';
      case Language.iw:
        return 'Hebrew';
      case Language.hi:
        return 'Hindi';
      case Language.hmn:
        return 'Hmong';
      case Language.hu:
        return 'Hungarian';
      case Language.is_:
        return 'Icelandic';
      case Language.ig:
        return 'Igbo';
      case Language.ilo:
        return 'Iloko';
      case Language.id:
        return 'Indonesian';
      case Language.ga:
        return 'Irish Gaelic';
      case Language.it:
        return 'Italian';
      case Language.ja:
        return 'Japanese';
      case Language.jw:
        return 'Javanese';
      case Language.kn:
        return 'Kannada';
      case Language.kk:
        return 'Kazakh';
      case Language.km:
        return 'Khmer';
      case Language.rw:
        return 'Kinyarwanda';
      case Language.gom:
        return 'Konkani';
      case Language.ko:
        return 'Korean';
      case Language.kri:
        return 'Krio';
      case Language.ku:
        return 'Kurdish (Kurmanji)';
      case Language.ckb:
        return 'Kurdish (Sorani)';
      case Language.ky:
        return 'Kyrgyz';
      case Language.lo:
        return 'Lao';
      case Language.la:
        return 'Latin';
      case Language.lv:
        return 'Latvian';
      case Language.ln:
        return 'Lingala';
      case Language.lt:
        return 'Lithuanian';
      case Language.lb:
        return 'Luxembourgish';
      case Language.mk:
        return 'Macedonian';
      case Language.mai:
        return 'Maithili';
      case Language.mg:
        return 'Malagasy';
      case Language.ms:
        return 'Malay';
      case Language.ml:
        return 'Malayalam';
      case Language.mt:
        return 'Maltese';
      case Language.mi:
        return 'Maori';
      case Language.mr:
        return 'Marathi';
      case Language.mniMtei:
        return 'Meiteilon (Manipuri)';
      case Language.lus:
        return 'Mizo';
      case Language.mn:
        return 'Mongolian';
      case Language.my:
        return 'Myanmar (Burmese)';
      case Language.ne:
        return 'Nepali';
      case Language.nso:
        return 'Northern Sotho';
      case Language.no:
        return 'Norwegian';
      case Language.or:
        return 'Odia (Oriya)';
      case Language.om:
        return 'Oromo';
      case Language.ps:
        return 'Pashto';
      case Language.fa:
        return 'Persian';
      case Language.pl:
        return 'Polish';
      case Language.pt:
        return 'Portuguese';
      case Language.pa:
        return 'Punjabi';
      case Language.qu:
        return 'Quechua';
      case Language.ro:
        return 'Romanian';
      case Language.ru:
        return 'Russian';
      case Language.sm:
        return 'Samoan';
      case Language.sa:
        return 'Sanskrit';
      case Language.gd:
        return 'Scots Gaelic';
      case Language.sr:
        return 'Serbian';
      case Language.st:
        return 'Sesotho';
      case Language.sn:
        return 'Shona';
      case Language.sd:
        return 'Sindhi';
      case Language.si:
        return 'Sinhala';
      case Language.sk:
        return 'Slovak';
      case Language.sl:
        return 'Slovenian';
      case Language.so:
        return 'Somali';
      case Language.es:
        return 'Spanish';
      case Language.su:
        return 'Sundanese';
      case Language.sw:
        return 'Swahili';
      case Language.sv:
        return 'Swedish';
      case Language.tg:
        return 'Tajik';
      case Language.ta:
        return 'Tamil';
      case Language.tt:
        return 'Tatar';
      case Language.te:
        return 'Telugu';
      case Language.th:
        return 'Thai';
      case Language.ti:
        return 'Tigrinya';
      case Language.ts:
        return 'Tsonga';
      case Language.tr:
        return 'Turkish';
      case Language.tk:
        return 'Turkmen';
      case Language.ak:
        return 'Twi';
      case Language.uk:
        return 'Ukrainian';
      case Language.ur:
        return 'Urdu';
      case Language.ug:
        return 'Uyghur';
      case Language.uz:
        return 'Uzbek';
      case Language.vi:
        return 'Vietnamese';
      case Language.cy:
        return 'Welsh';
      case Language.xh:
        return 'Xhosa';
      case Language.yi:
        return 'Yiddish';
      case Language.yo:
        return 'Yoruba';
      case Language.zu:
        return 'Zulu';
      case Language.he:
        return 'Hebrew';
      case Language.jv:
        return 'Javanese';
      case Language.zhCN:
        return 'Chinese (Simplified)';
      case Language.unknown:
        return 'Unknown';
    }
  }
}
