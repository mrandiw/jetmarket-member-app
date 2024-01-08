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

extension StringDateTimeFormatter on String {
  String get toCustomFormat {
    final daysInBahasa = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];

    final dateTime = DateTime.parse(this);
    final dayInWeek = daysInBahasa[dateTime.weekday % 7];

    final formattedDate =
        '${dayInWeek.substring(0, 1).toUpperCase()}${dayInWeek.substring(1)}, '
        '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')} WIB';

    return formattedDate;
  }
}
