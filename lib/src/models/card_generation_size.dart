enum CardGenrationSize {
  five,
  ten,
  twenty,
  fifty,
  hundred,
  hunderFifty,
  twoHundred,
  twoHundredsFifty;

  int toInt() {
    switch (this) {
      case CardGenrationSize.five:
        return 5;
      case CardGenrationSize.ten:
        return 10;
      case CardGenrationSize.twenty:
        return 20;
      case CardGenrationSize.fifty:
        return 50;
      case CardGenrationSize.hundred:
        return 100;
      case CardGenrationSize.hunderFifty:
        return 150;
      case CardGenrationSize.twoHundred:
        return 200;
      case CardGenrationSize.twoHundredsFifty:
        return 250;
    }
  }

  String getUiText() {
    return '${toInt()} cards';
  }

  String getDurationText() {
    switch (this) {
      case CardGenrationSize.five:
        return '~ 1 - 2 min';
      case CardGenrationSize.ten:
        return '~ 1 - 2 min';
      case CardGenrationSize.twenty:
        return '~ 1 - 2 min';
      case CardGenrationSize.fifty:
        return '~ 3 min';
      case CardGenrationSize.hundred:
        return '~ 5 min';
      case CardGenrationSize.hunderFifty:
        return '~ 5 min';
      case CardGenrationSize.twoHundred:
        return '~ 5 - 10 min';
      case CardGenrationSize.twoHundredsFifty:
        return '~ 5 - 10 min';
    }
  }

  bool isPlus() {
    switch (this) {
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hunderFifty:
      case CardGenrationSize.twoHundred:
      case CardGenrationSize.twoHundredsFifty:
        return true;
      default:
        return false;
    }
  }

  bool isAvailableForFiles() {
    switch (this) {
      case CardGenrationSize.twenty:
      case CardGenrationSize.fifty:
      case CardGenrationSize.hundred:
      case CardGenrationSize.hunderFifty:
      case CardGenrationSize.twoHundred:
      case CardGenrationSize.twoHundredsFifty:
        return true;
      default:
        return false;
    }
  }
}
