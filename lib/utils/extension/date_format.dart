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
      DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime dateTime = inputFormat.parse(this);

      String day = getDayName(dateTime.weekday);
      String formattedDate =
          '${_formatTwoDigits(dateTime.day)}/${_formatTwoDigits(dateTime.month)}/${dateTime.year}';
      String formattedTime =
          '${_formatTwoDigits(dateTime.hour)}:${_formatTwoDigits(dateTime.minute)}';
      String timeZone = getTimeZone(dateTime);
      String timeZoneConvert = timeZone == "+07:00"
          ? "WIB"
          : timeZone == "+08:00"
              ? "WITA"
              : "WIT";

      return '$day, $formattedDate $formattedTime $timeZoneConvert';
    } catch (e) {
      return 'Format tanggal tidak valid';
    }
  }

  String getDayName(int day) {
    switch (day) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  String getTimeZone(DateTime dateTime) {
    String timeZoneOffset = dateTime.timeZoneOffset.toString();
    String hours = _formatTwoDigits(dateTime.timeZoneOffset.inHours.abs());
    String minutes =
        _formatTwoDigits(dateTime.timeZoneOffset.inMinutes.abs() % 60);
    String sign = timeZoneOffset.startsWith('-') ? '-' : '+';

    return '$sign$hours:$minutes';
  }

  String _formatTwoDigits(int num) {
    return num < 10 ? '0$num' : '$num';
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
