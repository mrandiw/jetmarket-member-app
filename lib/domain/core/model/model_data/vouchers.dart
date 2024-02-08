class Vouchers {
  String? code;
  String? createdAt;
  String? discount;
  String? expiredAt;
  int? id;
  int? max;
  int? min;
  String? name;
  int? quota;

  Vouchers(
      {this.code,
      this.createdAt,
      this.discount,
      this.expiredAt,
      this.id,
      this.max,
      this.min,
      this.name,
      this.quota});

  Vouchers.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    createdAt = json['created_at'];
    discount = json['discount'];
    expiredAt = json['expired_at'];
    id = json['id'];
    max = json['max'];
    min = json['min'];
    name = json['name'];
    quota = json['quota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['created_at'] = createdAt;
    data['discount'] = discount;
    data['expired_at'] = expiredAt;
    data['id'] = id;
    data['max'] = max;
    data['min'] = min;
    data['name'] = name;
    data['quota'] = quota;
    return data;
  }
}
