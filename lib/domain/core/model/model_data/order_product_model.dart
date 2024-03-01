class OrderProductModel {
  int? id;
  String? orderRefId;
  String? image;
  String? name;
  int? price;
  int? quantity;
  Review? review;
  String? status;
  int? totalPrice;
  int? totalProduct;

  OrderProductModel(
      {this.id,
      this.orderRefId,
      this.image,
      this.name,
      this.price,
      this.quantity,
      this.review,
      this.status,
      this.totalPrice,
      this.totalProduct});

  OrderProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRefId = json['order_ref_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    status = json['status'];
    totalPrice = json['total_price'];
    totalProduct = json['total_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_ref_id'] = orderRefId;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['total_product'] = totalProduct;
    return data;
  }
}

class Review {
  String? createdAt;
  Customer? customer;
  int? id;
  String? image;
  int? rating;
  String? text;

  Review(
      {this.createdAt,
      this.customer,
      this.id,
      this.image,
      this.rating,
      this.text});

  Review.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    id = json['id'];
    image = json['image'];
    rating = json['rating'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['id'] = id;
    data['image'] = image;
    data['rating'] = rating;
    data['text'] = text;
    return data;
  }
}

class Customer {
  String? avatar;
  int? id;
  String? name;

  Customer({this.avatar, this.id, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
