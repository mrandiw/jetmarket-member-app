import 'package:intl/intl.dart';

extension CurrencyFormat on String {
  String get toIdrFormat {
    try {
      int amount = int.parse(this);
      String formatted = 'Rp. ${amount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match.group(1)}.',
          )}';

      return formatted;
    } catch (e) {
      return 'Rp. 0';
    }
  }
}

String getFormattedAmount(amount) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  ).format(amount ?? 0);
}
