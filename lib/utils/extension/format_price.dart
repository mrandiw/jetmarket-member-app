String formatPrice(int price) {
  String formattedPrice = '${price ~/ 1000} Rb';

  return formattedPrice;
}
