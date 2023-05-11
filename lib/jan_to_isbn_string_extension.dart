extension JanToIsbnStringExtension on String {
  String convertJanToIsbn() {
    if (length == 13) {
      String isbn = substring(3, 12);
      int checkDigit = 0;

      try {
        for (int i = 0; i < 9; i++) {
          checkDigit += int.parse(isbn[i]) * (i + 1);
        }
      } on FormatException {
        throw const FormatException('不正なJANコードです');
      }

      checkDigit %= 11;
      if (checkDigit == 10) {
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
