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
  String? phone;
  String? referral;
  String? email;

  User(
      {this.id, this.name, this.gender, this.phone, this.referral, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    phone = json['phone'];
    referral = json['referral'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['phone'] = phone;
    data['referral'] = referral;
    data['email'] = email;
    return data;
  }
}
