extension JanToIsbnStringExtension on String {
  String convertJanToIsbn() {
    int janCodeLength = 13;
    int startIsbnIndex = 3;
    int endIsbnIndex = 12;
    int checkDigitLoopCount = 9;
    int checkDigitModulo = 11;
    int checkDigitXValue = 10;

    if (length == janCodeLength) {
      String isbn = substring(startIsbnIndex, endIsbnIndex);
      int checkDigit = 0;

      try {
        for (int i = 0; i < checkDigitLoopCount; i++) {
          checkDigit += int.parse(isbn[i]) * (i + 1);
        }
      } on FormatException {
        throw const FormatException('不正なJANコードです');
      }

      checkDigit %= checkDigitModulo;

      if (checkDigit == checkDigitXValue) {
        isbn += 'X';
      } else {
        isbn += checkDigit.toString();
      }
      return isbn;
    } else {
      throw const FormatException('不正なJANコードです');
    }
  }
}
