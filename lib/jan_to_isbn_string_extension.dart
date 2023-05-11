extension JanToIsbnStringExtension on String {
  String convertJanToIsbn() {
    if (length == 13) {
      String isbn = substring(3, 12);
      int checkDigit = 0;
      for (int i = 0; i < 9; i++) {
        checkDigit += int.parse(isbn[i]) * (i + 1);
      }

      checkDigit %= 11;
      if (checkDigit == 10) {
        isbn += 'X';
      } else {
        isbn += checkDigit.toString();
      }
      return isbn;
    }
    return '';
  }
}
