class UserProfile {
  String? birthDate;
  String? email;
  String? gender;
  int? id;
  String? image;
  String? name;
  String? phone;
  String? referral;
  bool? isEmployee;
  bool? isVerified;
  String? activatedAt;

  UserProfile(
      {this.birthDate,
      this.email,
      this.gender,
      this.id,
      this.image,
      this.name,
      this.phone,
      this.referral,
      this.isEmployee,
      this.isVerified,
      this.activatedAt});

  UserProfile.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    phone = json['phone'];
    referral = json['referral'];
    isEmployee = json['is_employee'];
    isVerified = json['is_verified'];
    activatedAt = json['activated_at'];
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
    data['referral'] = referral;
    data['is_employee'] = isEmployee;
    data['is_verified'] = isVerified;
    data['activated_at'] = activatedAt;
    return data;
  }
}
