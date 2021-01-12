class CommomFunctions {
  static getGenreByID(int genreID) {
    switch (genreID) {
      case 12:
        return 'Aventura';
        break;
      case 14:
        return 'Fantasia';
        break;
      case 28:
        return 'Ação';
        break;
      case 35:
        return 'Comédia';
        break;
    }
  }

  static String formatClock(int minuts) {
    int hr = minuts ~/ 60;
    int min = minuts % 60;

    if (hr == 0) {
      return '$min min';
    } else {
      return '$hr\h $min min ';
    }
  }
}
