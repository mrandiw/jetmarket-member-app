class OrderProductModel {
  int? id;
  String? image;
  String? name;
  int? price;
  int? quantity;
  String? status;
  int? totalPrice;
  int? totalProduct;

  OrderProductModel(
      {this.id,
      this.image,
      this.name,
      this.price,
      this.quantity,
      this.status,
      this.totalPrice,
      this.totalProduct});

  OrderProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    status = json['status'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['total_product'] = totalProduct;
    return data;
  }
}
