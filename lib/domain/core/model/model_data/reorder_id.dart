class ReOrderId {
  int? cartId;

  ReOrderId({this.cartId});

  ReOrderId.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    return data;
  }
}
