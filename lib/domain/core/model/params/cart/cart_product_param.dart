class CartProductParam {
  const CartProductParam({
    required this.customerId,
    required this.page,
    required this.size,
  });

  final int customerId;
  final int page;
  final int size;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'page': page,
      'size': size
    };
    return map;
  }
}
