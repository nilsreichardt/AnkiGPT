enum Language {
  en,
  de,
  unknown;

  String getDisplayName() {
    switch (this) {
      case Language.en:
        return 'English';
      case Language.de:
        return 'German';
      case Language.unknown:
        return 'Unknown';
    }
  }
}
