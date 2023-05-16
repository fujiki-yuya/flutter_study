extension JanToIsbnStringExtension on String {
  String convertJanToIsbn() {
    int janCodeLength = 13;
    int startIsbnIndex = 3;
    int endIsbnIndex = 12;
    int checkDigitModulo = 11;
    int checkDigitXValue = 10;

    if (length == janCodeLength) {
      String isbn = substring(startIsbnIndex, endIsbnIndex);
      int checkDigit = 0;

      List<String> isbnList = isbn.split('');

      try {
        checkDigit = isbnList.asMap().entries.map((e) {
          return int.parse(e.value) * (e.key + 1);
        }).reduce((value, element) => value + element);
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
