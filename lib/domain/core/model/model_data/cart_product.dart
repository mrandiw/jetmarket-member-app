class CartProduct {
  String? createdAt;
  int? gramature;
  int? id;
  String? name;
  String? sellerName;
  String? variantName;
  String? note;
  int? price;
  int? promo;
  int? qty;
  int? sellerId;
  String? thumbnail;
  int? variantId;

  CartProduct(
      {this.createdAt,
      this.gramature,
      this.id,
      this.name,
      this.note,
      this.price,
      this.promo,
      this.qty,
      this.sellerId,
      this.thumbnail,
      this.variantId});

  CartProduct.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    gramature = json['gramature'];
    id = json['id'];
    name = json['name'];
    sellerName = json['seller_name'];
    variantName = json['variant_name'];
    note = json['note'];
    price = json['price'];
    promo = json['promo'];
    qty = json['qty'];
    sellerId = json['seller_id'];
    thumbnail = json['thumbnail'];
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['gramature'] = gramature;
    data['id'] = id;
    data['name'] = name;
    data['seller_name'] = sellerName;
    data['variant_name'] = variantName;
    data['note'] = note;
    data['price'] = price;
    data['promo'] = promo;
    data['qty'] = qty;
    data['seller_id'] = sellerId;
    data['thumbnail'] = thumbnail;
    data['variant_id'] = variantId;
    return data;
  }
}
