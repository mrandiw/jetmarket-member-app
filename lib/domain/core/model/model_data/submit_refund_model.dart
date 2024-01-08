class SubmitRefundModel {
  List<ProductVariants>? productVariants;
  int? totalAmount;

  SubmitRefundModel({this.productVariants, this.totalAmount});

  SubmitRefundModel.fromJson(Map<String, dynamic> json) {
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(ProductVariants.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productVariants != null) {
      data['product_variants'] =
          productVariants!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    return data;
  }
}

class ProductVariants {
  int? id;
  String? image;
  String? title;
  int? price;
  int? quantity;

  ProductVariants({this.id, this.image, this.title, this.price, this.quantity});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
