enum Language {
  english,
  german,
  unknown;

  String get name {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.german:
        return 'de';
      case Language.unknown:
        return 'unknown';
    }
  }

  String getDisplayName() {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.german:
        return 'German';
      case Language.unknown:
        return 'Unknown';
    }
  }
}
