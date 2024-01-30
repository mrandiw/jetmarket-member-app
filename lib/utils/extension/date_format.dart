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
      return 'Invalid date format';
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
    // DateTime dateTime = DateTime.parse(this);
    // return '${dateTime.hour}:${dateTime.minute}';
    try {
      final parsedDate = DateTime.parse(this);
      final formattedTime =
          "${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";
      return formattedTime;
    } catch (e) {
      return this; // return original string jika parsing gagal
    }
  }

  String get convertToDateFormat {
    try {
      // Remove trailing "+0000 +0000"
      String cleanedDate = replaceAll("+0000 +0000", "").trim();

      // Parse the cleaned string to a DateTime object
      DateTime dateTime = DateTime.parse(cleanedDate);

      // Format the DateTime object to the desired format
      String formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year}";

      return formattedDate;
    } catch (e) {
      // Handle the case where the input string is not a valid date
      return "Invalid Date";
    }
  }
}

extension FormatCreatedAtExtension on String {
  String get formatCreatedAt {
    // ignore: unnecessary_null_comparison
    if (this == null) {
      return ""; // Return an empty string if the string is null
    }

    // Identifikasi nilai "0001-01-01 00:00:00 +0000 +0000" dan ganti dengan nilai yang sesuai
    if (this == "0001-01-01 00:00:00 +0000 +0000") {
      return "2024-01-27 15:41:27";
    }

    try {
      DateTime createdAt = DateTime.parse(this);
      return DateFormat("yyyy-MM-dd").format(createdAt);
    } catch (e) {
      // Jika parsing gagal, kembalikan string tanpa perubahan
      return this;
    }
  }
}
