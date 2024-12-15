class DetailShop {
  int? id;
  String? name;
  String? avatar;
  double? rating;
  String? address;
  double? lat;
  double? lng;
  String? openAt;
  String? closeAt;

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
    rating = double.parse("${json['rating']}");
    address = json['address'];
    if (json['lat'] == 0) {
      lat = 0.0;
    } else {
      lat = double.parse("${json['lat']}");
    }
    if (json['lng'] == 0) {
      lng = 0.0;
    } else {
      lng = double.parse("${json['lng']}");
    }
    openAt = json['open_at'];
    closeAt = json['close_at'];
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
    data['open_at'] = openAt;
    data['close_at'] = closeAt;
    return data;
  }
}
