import 'package:intl/intl.dart';

extension StringExtension on String {
  String get convertToLocaleDate {
    DateTime parsedDate = DateTime.parse(this);
    DateTime localDate = parsedDate.toLocal();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String convertedDate = dateFormat.format(localDate);
    return convertedDate;
  }

  String get convertToLocaleDay {
    DateTime parsedDate = DateTime.parse(this);
    DateTime localDate = parsedDate.toLocal();
    DateFormat dateFormat = DateFormat("E, dd MMM yyyy", 'id_ID');
    String convertedDate = dateFormat.format(localDate);
    return convertedDate;
  }

  String get convertToLocaleTime {
    DateTime parsedDate = DateTime.parse(this);
    DateTime localDate = parsedDate.toLocal();
    DateFormat dateFormat = DateFormat("HH:mm");
    String convertedDate = dateFormat.format(localDate);
    return convertedDate;
  }
}
