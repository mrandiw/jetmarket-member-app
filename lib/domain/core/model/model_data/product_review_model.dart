import 'package:jetmarket/domain/core/model/model_data/order_product_model.dart';

class ProductReviewModel {
  int? id;
  int? orderItemId;
  String? image;
  String? name;
  int? quantity;
  int? price;
  int? productId;
  Review? review;

  ProductReviewModel(
      {this.id,
      this.orderItemId,
      this.image,
      this.name,
      this.quantity,
      this.price,
      this.productId});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderItemId = json['order_item_id'];
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    productId = json['product_id'];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_item_id'] = orderItemId;
    data['image'] = image;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}
