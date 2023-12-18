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
