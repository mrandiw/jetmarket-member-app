class CheckingAuth {
  int? id;
  bool? isVerified;
  String? activatedAt;

  CheckingAuth({this.id, this.isVerified, this.activatedAt});

  CheckingAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isVerified = json['is_verified'];
    activatedAt = json['activated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_verified'] = isVerified;
    data['activated_at'] = activatedAt;
    return data;
  }
}
