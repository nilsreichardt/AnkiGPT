enum CardGenrationSize {
  five,
  ten,
  twenty,
  thirtyFive,
  fifty,
  seventyFive,
  hundred,
  hundertFifty;

  int toInt() {
    switch (this) {
      case CardGenrationSize.five:
        return 5;
      case CardGenrationSize.ten:
        return 10;
      case CardGenrationSize.twenty:
        return 20;
      case CardGenrationSize.thirtyFive:
        return 35;
      case CardGenrationSize.fifty:
        return 50;
      case CardGenrationSize.seventyFive:
        return 75;
      case CardGenrationSize.hundred:
        return 100;
      case CardGenrationSize.hundertFifty:
        return 150;
    }
  }

  String getUiText() {
    return '${toInt()}';
  }

  bool isPlus() {
    switch (this) {
      case CardGenrationSize.thirtyFive:
      case CardGenrationSize.fifty:
      case CardGenrationSize.seventyFive:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hundertFifty:
        return true;
      default:
        return false;
    }
  }

  bool isAvailableForFiles() {
    switch (this) {
      case CardGenrationSize.twenty:
      case CardGenrationSize.thirtyFive:
      case CardGenrationSize.fifty:
      case CardGenrationSize.seventyFive:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hundertFifty:
        return true;
      default:
        return false;
    }
  }
}
