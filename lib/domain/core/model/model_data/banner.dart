class Banners {
  String? createdAt;
  int? id;
  String? image;
  bool? isActive;
  String? link;
  String? updatedAt;

  Banners(
      {this.createdAt,
      this.id,
      this.image,
      this.isActive,
      this.link,
      this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    image = json['image'];
    isActive = json['is_active'];
    link = json['link'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['image'] = image;
    data['is_active'] = isActive;
    data['link'] = link;
    data['updated_at'] = updatedAt;
    return data;
  }
}
