extension PhoneNumberExtension on String {
  String get convertToInternationalFormat {
    if (startsWith('0')) {
      return '+62${substring(1)}';
    }
    return this;
  }
}
