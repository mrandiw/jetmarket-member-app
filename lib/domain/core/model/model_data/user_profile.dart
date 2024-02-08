class UserProfile {
  String? birthDate;
  String? email;
  String? gender;
  int? id;
  String? image;
  String? name;
  String? phone;

  UserProfile(
      {this.birthDate,
      this.email,
      this.gender,
      this.id,
      this.image,
      this.name,
      this.phone});

  UserProfile.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['birth_date'] = birthDate;
    data['email'] = email;
    data['gender'] = gender;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
