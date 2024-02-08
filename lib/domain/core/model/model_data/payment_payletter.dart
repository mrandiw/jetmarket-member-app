class PaymentPayletter {
  List<Installments>? installments;
  String? terms;

  PaymentPayletter({this.installments, this.terms});

  PaymentPayletter.fromJson(Map<String, dynamic> json) {
    if (json['installments'] != null) {
      installments = <Installments>[];
      json['installments'].forEach((v) {
        installments!.add(Installments.fromJson(v));
      });
    }
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (installments != null) {
      data['installments'] = installments!.map((v) => v.toJson()).toList();
    }
    data['terms'] = terms;
    return data;
  }
}

class Installments {
  String? chCode;
  String? chType;
  int? id;
  String? name;
  int? value;

  Installments({this.chCode, this.chType, this.id, this.name, this.value});

  Installments.fromJson(Map<String, dynamic> json) {
    chCode = json['ch_code'];
    chType = json['ch_type'];
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
