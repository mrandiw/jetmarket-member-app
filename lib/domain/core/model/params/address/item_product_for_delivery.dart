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
  int? variantId;
  int? value;
  int? qty;

  Products({this.variantId, this.value, this.qty});

  Products.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    value = json['value'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant_id'] = variantId;
    data['value'] = value;
    data['qty'] = qty;
    return data;
  }
}
