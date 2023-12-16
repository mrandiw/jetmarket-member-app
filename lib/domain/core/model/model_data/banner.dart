class Banners {
  int? id;
  String? image;
  String? link;
  bool? isActive;
  String? updatedAt;
  String? createdAt;

  Banners(
      {this.id,
      this.image,
      this.link,
      this.isActive,
      this.updatedAt,
      this.createdAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['link'] = link;
    data['is_active'] = isActive;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
