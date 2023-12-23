class CartBody {
  const CartBody({
    required this.sellerId,
    required this.customerId,
    required this.productId,
    required this.variantId,
  });

  final int sellerId;
  final int customerId;
  final int productId;
  final int variantId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'seller_id': sellerId,
      'customer_id': customerId,
      'product_id': productId,
      'variant_id': variantId
    };
    return map;
  }
}
