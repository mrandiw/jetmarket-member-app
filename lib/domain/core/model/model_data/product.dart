class Product {
  int? id;
  String? name;
  String? thumbnail;
  int? price;
  int? promo;
  int? sold;
  double? rating;
  String? description;

  Product(
      {this.id,
      this.name,
      this.thumbnail,
      this.price,
      this.promo,
      this.sold,
      this.rating,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    promo = json['promo'];
    sold = json['sold'];
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['promo'] = promo;
    data['sold'] = sold;
    data['rating'] = rating;
    data['description'] = description;
    return data;
  }
}
