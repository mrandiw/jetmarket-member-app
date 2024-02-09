class PaymentMethodeModel {
  List<VirtualAccount>? virtualAccount;
  List<Otc>? otc;
  List<EWalletQr>? ewalletQr;
  List<Payletter>? paylater;
  List<Saldo>? saldo;

  PaymentMethodeModel(
      {this.virtualAccount, this.otc, this.ewalletQr, this.paylater});

  PaymentMethodeModel.fromJson(Map<String, dynamic> json) {
    if (json['ewallet'] != null || json['qr_code'] != null) {
      ewalletQr = <EWalletQr>[];
      json['ewallet'].forEach((v) {
        ewalletQr!.add(EWalletQr.fromJson(v));
      });

      // Ambil satu data pertama dari 'qr_code'
      if (json['qr_code'] != null && json['qr_code'].isNotEmpty) {
        ewalletQr!.add(EWalletQr.fromJson(
            json['qr_code'].first)); // Mengambil elemen pertama dari 'qr_code'
        // Jika ingin menggunakan take(1) dengan forEach:
        // json['qr_code'].take(1).forEach((v) {
        //   ewalletQr!.add(EWalletQr.fromJson(v));
        // });
      }
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
    if (json['paylater'] != null) {
      paylater = <Payletter>[];
      json['paylater'].forEach((v) {
        paylater!.add(Payletter.fromJson(v));
      });
    }

    if (json['saldo'] != null) {
      saldo = <Saldo>[];
      json['saldo'].forEach((v) {
        saldo!.add(Saldo.fromJson(v));
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
    if (paylater != null) {
      data['paylater'] = paylater!.map((v) => v.toJson()).toList();
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

class Payletter {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  Payletter({this.id, this.chType, this.chCode, this.name, this.createdAt});

  Payletter.fromJson(Map<String, dynamic> json) {
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

class Saldo {
  int? amount;
  String? name;
  String? chCode;
  String? chType;

  Saldo({this.amount, this.name, this.chCode, this.chType});

  Saldo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    name = json['name'];
    chCode = json['ch_code'];
    chType = json['ch_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['name'] = name;
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    return data;
  }
}
