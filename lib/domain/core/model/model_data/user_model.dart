class UserModel {
  int? trxId;
  String? token;
  User? user;

  UserModel({this.trxId, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    trxId = json['trx_id'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trx_id'] = trxId;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? gender;
  String? birthDate;
  String? phone;
  String? referral;
  String? email;
  bool? isEmployee;
  bool? isVerified;
  String? activatedAt;

  User(
      {this.id,
      this.name,
      this.gender,
      this.birthDate,
      this.phone,
      this.referral,
      this.email,
      this.isEmployee,
      this.isVerified,
      this.activatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    phone = json['phone'];
    referral = json['referral'];
    email = json['email'];
    isEmployee = json['is _employee'];
    isVerified = json['is verified'];
    activatedAt = json['activated at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['phone'] = phone;
    data['referral'] = referral;
    data['email'] = email;
    data['is _employee'] = isEmployee;
    data['is verified'] = isVerified;
    data['activated at'] = activatedAt;
    return data;
  }
}
