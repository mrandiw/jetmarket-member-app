extension StringFormatting on String {
  String get formatText {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ')
        .trim();
  }
}
