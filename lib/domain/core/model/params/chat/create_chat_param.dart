class CreateChatParam {
  int? fromId;
  String? fromRole;
  int? toId;
  String? toRole;
  int? productId;
  int? orderId;

  CreateChatParam(
      {this.fromId,
      this.fromRole,
      this.toId,
      this.toRole,
      this.productId,
      this.orderId});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_id'] = fromId;
    data['from_role'] = fromRole;
    data['to_id'] = toId;
    data['to_role'] = toRole;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
