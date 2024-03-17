class CartProduct {
  List<Products>? products;
  Seller? seller;

  CartProduct({this.products, this.seller});

  CartProduct.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    return data;
  }
}

class Products {
  int? cartId;
  String? name;
  String? note;
  int? price;
  int? promo;
  int? qty;
  String? thumbnail;
  int? variantId;
  String? variantName;
  int? weight;
  int? stock;

  Products(
      {this.cartId,
      this.name,
      this.note,
      this.price,
      this.promo,
      this.qty,
      this.thumbnail,
      this.variantId,
      this.variantName,
      this.weight,
      this.stock});

  Products.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    name = json['name'];
    note = json['note'];
    price = json['price'];
    promo = json['promo'];
    qty = json['qty'];
    thumbnail = json['thumbnail'];
    variantId = json['variant_id'];
    variantName = json['variant_name'];
    weight = json['weight'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['name'] = name;
    data['note'] = note;
    data['price'] = price;
    data['promo'] = promo;
    data['qty'] = qty;
    data['thumbnail'] = thumbnail;
    data['variant_id'] = variantId;
    data['variant_name'] = variantName;
    data['weight'] = weight;
    data['stock'] = stock;
    return data;
  }
}

class Seller {
  int? id;
  String? name;

  Seller({this.id, this.name});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
