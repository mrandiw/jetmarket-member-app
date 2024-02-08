extension StringExtension on String {
  String get getSubstringBeforeHash {
    int indexOfHash = indexOf('#');

    return indexOfHash != -1 ? substring(0, indexOfHash) : this;
  }
}
