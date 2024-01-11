class SubmitRefundModel {
  List<Products>? products;
  int? totalAmount;

  SubmitRefundModel({this.products, this.totalAmount});

  SubmitRefundModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    return data;
  }
}

class Products {
  String? image;
  int? price;
  int? quantity;
  String? title;
  int? variantId;

  Products({this.image, this.price, this.quantity, this.title, this.variantId});

  Products.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    title = json['title'];
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    data['title'] = title;
    data['variant_id'] = variantId;
    return data;
  }
}
