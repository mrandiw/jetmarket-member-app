class SavingPaymentMethodeModel {
  Saldo? saldo;
  List<Items>? items;

  SavingPaymentMethodeModel({this.saldo, this.items});

  SavingPaymentMethodeModel.fromJson(Map<String, dynamic> json) {
    saldo = json['saldo'] != null ? Saldo.fromJson(json['saldo']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saldo != null) {
      data['saldo'] = saldo!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Saldo {
  int? total;
  String? title;
  String? chCode;
  String? chType;

  Saldo({this.total, this.title, this.chCode, this.chType});

  Saldo.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    title = json['title'];
    chCode = json['ch_code'];
    chType = json['ch_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['title'] = title;
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    return data;
  }
}

class Items {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  Items({this.id, this.chType, this.chCode, this.name, this.createdAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chType = json['ch_type'];
    chCode = json['ch_code'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ch_type'] = chType;
    data['ch_code'] = chCode;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
