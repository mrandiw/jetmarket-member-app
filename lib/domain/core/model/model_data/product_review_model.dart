class ProductReviewModel {
  int? id;
  String? image;
  String? name;
  int? quantity;
  int? price;
  int? productId;

  ProductReviewModel(
      {this.id,
      this.image,
      this.name,
      this.quantity,
      this.price,
      this.productId});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
