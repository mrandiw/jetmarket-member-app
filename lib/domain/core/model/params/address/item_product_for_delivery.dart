class ItemProductForDelivery {
  int? addressId;
  List<Items>? items;

  ItemProductForDelivery({this.addressId, this.items});

  ItemProductForDelivery.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? sellerId;
  List<Products>? products;

  Items({this.sellerId, this.products});

  Items.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productName;
  int? variantId;
  int? value;
  int? qty;
  String? note;

  Products({this.productName, this.variantId, this.value, this.qty, this.note});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    variantId = json['variant_id'];
    value = json['price'];
    qty = json['quantity'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['variant_id'] = variantId;
    data['price'] = value;
    data['quantity'] = qty;
    data['note'] = note;
    return data;
  }
}
