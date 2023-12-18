class CategoryProduct {
  int? id;
  String? name;
  String? image;
  String? updatedAt;
  String? createdAt;

  CategoryProduct(
      {this.id, this.name, this.image, this.updatedAt, this.createdAt});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
