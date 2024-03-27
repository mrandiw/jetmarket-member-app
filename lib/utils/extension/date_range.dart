extension DateRangeExtension on String {
  String get dateRangeConvert {
    List<String> dates = split(' & ');
    if (dates.length == 2) {
      DateTime startDate = DateTime.parse(dates[0]).toLocal();
      DateTime endDate = DateTime.parse(dates[1]).toLocal();

      String startMonth = _getMonthName(startDate.month);
      String endMonth = _getMonthName(endDate.month);

      if (startDate.year == endDate.year) {
        // Jika tahunnya sama
        return '${startDate.day} $startMonth - ${endDate.day} $endMonth ${endDate.year}';
      } else {
        // Jika tahunnya berbeda
        return '${startDate.day} $startMonth ${startDate.year} - ${endDate.day} $endMonth ${endDate.year}';
      }
    }
    return this;
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'Mei';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Ags';
      case 9:
        return 'Sep';
      case 10:
        return 'Okt';
      case 11:
        return 'Nov';
      case 12:
        return 'Des';
      default:
        return '';
    }
  }
}
