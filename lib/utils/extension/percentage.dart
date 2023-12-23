extension PercentageParser on String {
  double get parsePercentageToDouble {
    // Mengambil bagian angka dari string dan mengubahnya menjadi double
    final value = double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), ''));
    return value != null ? value / 100 : 0.0;
  }
}
