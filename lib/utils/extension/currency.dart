extension CurrencyFormat on String {
  String get toIdrFormat {
    try {
      // Ubah string ke integer
      int amount = int.parse(this);

      // Format angka ke format mata uang Rupiah
      String formatted = 'Rp. ${amount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match.group(1)}.',
          )}';

      return formatted;
    } catch (e) {
      // Tangani jika terjadi kesalahan parsing atau konversi
      print('Error: $e');
      return 'Rp. 0'; // Atau format default jika parsing gagal
    }
  }
}
