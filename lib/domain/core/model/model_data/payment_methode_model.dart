class PaymentMethodeModel {
  // List<Ewallet>? ewallet;
  // List<QrCode>? qrCode;
  List<VirtualAccount>? virtualAccount;
  List<Otc>? otc;
  List<EWalletQr>? ewalletQr;

  PaymentMethodeModel({this.virtualAccount, this.otc, this.ewalletQr});

  PaymentMethodeModel.fromJson(Map<String, dynamic> json) {
    if (json['ewallet'] != null || json['qr_code'] != null) {
      ewalletQr = <EWalletQr>[];
      json['ewallet'].forEach((v) {
        ewalletQr!.add(EWalletQr.fromJson(v));
      });
      json['qr_code'].forEach((v) {
        ewalletQr!.add(EWalletQr.fromJson(v));
      });
    }

    if (json['virtual_account'] != null) {
      virtualAccount = <VirtualAccount>[];
      json['virtual_account'].forEach((v) {
        virtualAccount!.add(VirtualAccount.fromJson(v));
      });
    }
    if (json['otc'] != null) {
      otc = <Otc>[];
      json['otc'].forEach((v) {
        otc!.add(Otc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (virtualAccount != null) {
      data['virtual_account'] = virtualAccount!.map((v) => v.toJson()).toList();
    }
    if (otc != null) {
      data['otc'] = otc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ewallet {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  Ewallet({this.id, this.chType, this.chCode, this.name, this.createdAt});

  Ewallet.fromJson(Map<String, dynamic> json) {
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

class QrCode {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  QrCode({this.id, this.chType, this.chCode, this.name, this.createdAt});

  QrCode.fromJson(Map<String, dynamic> json) {
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

class VirtualAccount {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  VirtualAccount(
      {this.id, this.chType, this.chCode, this.name, this.createdAt});

  VirtualAccount.fromJson(Map<String, dynamic> json) {
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

class Otc {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  Otc({this.id, this.chType, this.chCode, this.name, this.createdAt});

  Otc.fromJson(Map<String, dynamic> json) {
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

class EWalletQr {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  EWalletQr({this.id, this.chType, this.chCode, this.name, this.createdAt});

  EWalletQr.fromJson(Map<String, dynamic> json) {
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
