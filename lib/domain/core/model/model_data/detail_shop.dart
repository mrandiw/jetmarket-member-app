class DetailShop {
  int? id;
  String? name;
  String? avatar;
  double? rating;
  String? address;
  double? lat;
  double? lng;

  DetailShop(
      {this.id,
      this.name,
      this.avatar,
      this.rating,
      this.address,
      this.lat,
      this.lng});

  DetailShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    if (json['rating'] == 0) {
      rating = 0.0;
    } else {
      rating = json['rating'];
    }
    address = json['address'];
    if (json['lat'] == 0) {
      lat = 0.0;
    } else {
      lat = json['lat'];
    }
    if (json['lng'] == 0) {
      lng = 0.0;
    } else {
      lng = json['lng'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    data['rating'] = rating;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
