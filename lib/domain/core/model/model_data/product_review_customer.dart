class ProductReviewCustomer {
  int? id;
  Customer? customer;
  double? rating;
  String? image;
  String? text;
  String? createdAt;

  ProductReviewCustomer(
      {this.id,
      this.customer,
      this.rating,
      this.image,
      this.text,
      this.createdAt});

  ProductReviewCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    rating = json['rating'];
    image = json['image'];
    text = json['text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['rating'] = rating;
    data['image'] = image;
    data['text'] = text;
    data['created_at'] = createdAt;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? avatar;

  Customer({this.id, this.name, this.avatar});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
