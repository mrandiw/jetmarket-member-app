extension NumberFormatExtension on String {
  String get formatNumber {
    String value = this;
    double number = double.parse(value);
    String result = '';

    if (number < 999) {
      result = value;
    } else if (number <= 999999) {
      result =
          '${(number / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0'), '')}rb';
    } else if (number < 10000000) {
      result =
          '${(number / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0'), '')}jt';
    } else if (number == 10000000) {
      result =
          '${(number / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0'), '')}jt';
    } else if (number > 10000000) {
      result = '10jt++';
    } else {
      result = value;
    }

    return result;
  }
}
