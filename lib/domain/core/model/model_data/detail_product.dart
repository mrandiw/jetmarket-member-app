class DetailProduct {
  int? id;
  String? name;
  List<String>? images;
  String? thumbnail;
  int? price;
  int? promo;
  int? sold;
  double? rating;
  String? description;
  List<Variants>? variants;
  Seller? seller;
  Review? review;

  DetailProduct(
      {this.id,
      this.name,
      this.images,
      this.thumbnail,
      this.price,
      this.promo,
      this.sold,
      this.rating,
      this.description,
      this.variants,
      this.seller,
      this.review});

  DetailProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
    price = json['price'];
    promo = json['promo'];
    sold = json['sold'];
    if (json['rating'] == 0) {
      rating = 0.0;
    } else {
      rating = json['rating'];
    }
    description = json['description'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['promo'] = promo;
    data['sold'] = sold;
    data['rating'] = rating;
    data['description'] = description;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class Variants {
  int? id;
  String? name;
  String? image;

  Variants({this.id, this.name, this.image});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Seller {
  int? id;
  String? name;
  String? city;
  String? avatar;

  Seller({this.id, this.name, this.city, this.avatar});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['avatar'] = avatar;
    return data;
  }
}

class Review {
  double? averrage;
  int? total;

  Review({this.averrage, this.total});

  Review.fromJson(Map<String, dynamic> json) {
    averrage = json['averrage'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['averrage'] = averrage;
    data['total'] = total;
    return data;
  }
}
