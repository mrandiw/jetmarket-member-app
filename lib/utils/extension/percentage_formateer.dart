extension PercentExtension on String {
  String get adjustPercentPosition {
    if (contains('%')) {
      List<String> parts = split('%');
      return "${parts[1]}%".trim();
    }
    return this;
  }
}
