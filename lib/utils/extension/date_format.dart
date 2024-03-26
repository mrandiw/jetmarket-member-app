import 'dart:developer';

import 'package:intl/intl.dart';

extension DateFormatter on String {
  String get formatDate {
    try {
      final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      final outputFormat = DateFormat('dd MMM yyyy, HH:mm');

      final dateTime = inputFormat.parse(this);
      final formattedDate = outputFormat.format(dateTime);

      return formattedDate;
    } catch (e) {
      return this;
    }
  }
}

extension DateFormatExtension on String {
  String get convertToCustomFormat {
    try {
      DateTime parseDate = DateTime.parse(this);
      DateTime localDate = parseDate.toLocal();
      String day = getDayName(localDate.weekday);
      String formattedDate =
          '${_formatTwoDigits(localDate.day)}/${_formatTwoDigits(localDate.month)}/${localDate.year}';
      String formattedTime =
          '${_formatTwoDigits(localDate.hour)}:${_formatTwoDigits(localDate.minute)}';
      String timeZone = getTimeZone(localDate);
      log("timeZone: $timeZone");
      String timeZoneConvert = timeZone == "7:0"
          ? "WIB"
          : timeZone == "8:0"
              ? "WITA"
              : "WIT";

      return '$day, $formattedDate $formattedTime $timeZoneConvert';
    } catch (e) {
      return 'Invalid date format';
    }
  }

  String getDayName(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }

  String _formatTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }

  String getTimeZone(DateTime dateTime) {
    String offset = dateTime.timeZoneOffset.toString();
    String hours = offset.substring(0, 3);
    String timeZone = hours;
    return timeZone;
  }

  String get formatToHourMinute {
    try {
      final cleanedDate = replaceAll("+0000 +0000", "").trim();
      final parsedDate = DateTime.parse(cleanedDate);
      final formattedTime =
          "${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";
      return formattedTime;
    } catch (e) {
      return this;
    }
  }

  String get convertToDateFormat {
    try {
      String cleanedDate = replaceAll("+0000 +0000", "").trim();
      DateTime dateTime = DateTime.parse(cleanedDate);
      String formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year}";

      return formattedDate;
    } catch (e) {
      return this;
    }
  }
}

extension FormatCreatedAtExtension on String {
  String get formatCreatedAt {
    // ignore: unnecessary_null_comparison
    if (this == null) {
      return "";
    }
    String cleanedDate = replaceAll("+0000 +0000", "").trim();
    if (cleanedDate == "0001-01-01 00:00:00") {
      return "2024-01-27 15:41:27";
    }

    try {
      DateTime createdAt = DateTime.parse(cleanedDate);
      return DateFormat("yyyy-MM-dd").format(createdAt);
    } catch (e) {
      return this;
    }
  }
}

extension MonthName on String {
  String get getMonthName {
    final monthNames = {
      'en': [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ],
      'id': [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ]
    };

    final dateParts = split('-');
    final monthIndex = int.parse(dateParts[1]) - 1;

    return monthNames['id']![monthIndex];
  }
}

extension YearValue on String {
  int get getYear {
    final dateParts = split('-');
    return int.parse(dateParts[0]);
  }
}

extension StringDateTimeConversion on String {
  String get toDateDay {
    DateTime dateTime = DateTime.parse(this).toLocal();
    String formattedDate =
        '${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}, ${_formatTime(dateTime)}';
    return formattedDate;
  }

  String _monthName(int month) {
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
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _formatTime(DateTime dateTime) {
    String formattedTime =
        '${dateTime.hour}.${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
