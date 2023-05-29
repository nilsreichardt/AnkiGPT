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
  az, // Azerbaijani
  eu, // Basque
  be, // Belarusian
  bn, // Bengali
  bs, // Bosnian
  bg, // Bulgarian
  my, // Burmese
  ca, // Catalan
  zh, // Chinese
  hr, // Croatian
  cs, // Czech
  da, // Danish
  nl, // Dutch
  en, // English
  et, // Estonian
  fa, // Persian
  fi, // Finnish
  fr, // French
  gl, // Galician
  ka, // Georgian
  de, // German
  el, // Greek
  gu, // Gujarati
  ht, // Haitian Creole
  he, // Hebrew
  hi, // Hindi
  hu, // Hungarian
  // is, // Icelandic, reserved keyword in Dart
  id, // Indonesian
  ga, // Irish
  it, // Italian
  ja, // Japanese
  kn, // Kannada
  kk, // Kazakh
  km, // Khmer
  ko, // Korean
  ku, // Kurdish
  ky, // Kyrgyz
  lo, // Lao
  lv, // Latvian
  lt, // Lithuanian
  lb, // Luxembourgish
  mk, // Macedonian
  mg, // Malagasy
  ms, // Malay
  ml, // Malayalam
  mt, // Maltese
  mr, // Marathi
  mn, // Mongolian
  ne, // Nepali
  no, // Norwegian
  oc, // Occitan
  or, // Odia
  ps, // Pashto
  pl, // Polish
  pt, // Portuguese
  pa, // Punjabi
  ro, // Romanian
  ru, // Russian
  sm, // Samoan
  gd, // Scottish Gaelic
  sr, // Serbian
  sd, // Sindhi
  si, // Sinhala
  sk, // Slovak
  sl, // Slovenian
  so, // Somali
  st, // Southern Sotho
  es, // Spanish
  sw, // Swahili
  sv, // Swedish
  tl, // Tagalog
  tg, // Tajik
  ta, // Tamil
  te, // Telugu
  th, // Thai
  tr, // Turkish
  tk, // Turkmen
  uk, // Ukrainian
  ur, // Urdu
  ug, // Uyghur
  uz, // Uzbek
  vi, // Vietnamese
  cy, // Welsh
  fy, // Western Frisian
  xh, // Xhosa
  yi, // Yiddish
  yo, // Yoruba
  zu, // Zulu
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
      case Language.az:
        return 'Azerbaijani';
      case Language.eu:
        return 'Basque';
      case Language.be:
        return 'Belarusian';
      case Language.bn:
        return 'Bengali';
      case Language.bs:
        return 'Bosnian';
      case Language.bg:
        return 'Bulgarian';
      case Language.my:
        return 'Burmese';
      case Language.ca:
        return 'Catalan';
      case Language.zh:
        return 'Chinese';
      case Language.hr:
        return 'Croatian';
      case Language.cs:
        return 'Czech';
      case Language.da:
        return 'Danish';
      case Language.nl:
        return 'Dutch';
      case Language.en:
        return 'English';
      case Language.et:
        return 'Estonian';
      case Language.fa:
        return 'Persian';
      case Language.fi:
        return 'Finnish';
      case Language.fr:
        return 'French';
      case Language.gl:
        return 'Galician';
      case Language.ka:
        return 'Georgian';
      case Language.de:
        return 'German';
      case Language.el:
        return 'Greek';
      case Language.gu:
        return 'Gujarati';
      case Language.ht:
        return 'Haitian Creole';
      case Language.he:
        return 'Hebrew';
      case Language.hi:
        return 'Hindi';
      case Language.hu:
        return 'Hungarian';
      // case Language.is: // is, reserved keyword in Dart
      //   return 'Icelandic';
      case Language.id:
        return 'Indonesian';
      case Language.ga:
        return 'Irish';
      case Language.it:
        return 'Italian';
      case Language.ja:
        return 'Japanese';
      case Language.kn:
        return 'Kannada';
      case Language.kk:
        return 'Kazakh';
      case Language.km:
        return 'Khmer';
      case Language.ko:
        return 'Korean';
      case Language.ku:
        return 'Kurdish';
      case Language.ky:
        return 'Kyrgyz';
      case Language.lo:
        return 'Lao';
      case Language.lv:
        return 'Latvian';
      case Language.lt:
        return 'Lithuanian';
      case Language.lb:
        return 'Luxembourgish';
      case Language.mk:
        return 'Macedonian';
      case Language.mg:
        return 'Malagasy';
      case Language.ms:
        return 'Malay';
      case Language.ml:
        return 'Malayalam';
      case Language.mt:
        return 'Maltese';
      case Language.mr:
        return 'Marathi';
      case Language.mn:
        return 'Mongolian';
      case Language.ne:
        return 'Nepali';
      case Language.no:
        return 'Norwegian';
      case Language.oc:
        return 'Occitan';
      case Language.or:
        return 'Odia';
      case Language.ps:
        return 'Pashto';
      case Language.pl:
        return 'Polish';
      case Language.pt:
        return 'Portuguese';
      case Language.pa:
        return 'Punjabi';
      case Language.ro:
        return 'Romanian';
      case Language.ru:
        return 'Russian';
      case Language.sm:
        return 'Samoan';
      case Language.gd:
        return 'Scottish Gaelic';
      case Language.sr:
        return 'Serbian';
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
      case Language.st:
        return 'Southern Sotho';
      case Language.es:
        return 'Spanish';
      case Language.sw:
        return 'Swahili';
      case Language.sv:
        return 'Swedish';
      case Language.tl:
        return 'Tagalog';
      case Language.tg:
        return 'Tajik';
      case Language.ta:
        return 'Tamil';
      case Language.te:
        return 'Telugu';
      case Language.th:
        return 'Thai';
      case Language.tr:
        return 'Turkish';
      case Language.tk:
        return 'Turkmen';
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
      case Language.fy:
        return 'Western Frisian';
      case Language.xh:
        return 'Xhosa';
      case Language.yi:
        return 'Yiddish';
      case Language.yo:
        return 'Yoruba';
      case Language.zu:
        return 'Zulu';
      case Language.unknown:
        return 'Unknown';
    }
  }
}
