class OrderCustomerPaymentModel {
  int? id;
  int? orderId;
  String? referenceId;
  String? name;
  int? amount;
  String? phone;
  String? status;
  Channel? channel;
  Ewallet? ewallet;
  VirtualAccount? virtualAccount;
  QrCode? qrCode;
  Otc? otc;

  OrderCustomerPaymentModel(
      {this.id,
      this.orderId,
      this.referenceId,
      this.name,
      this.amount,
      this.phone,
      this.status,
      this.channel,
      this.ewallet,
      this.virtualAccount,
      this.qrCode,
      this.otc});

  OrderCustomerPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    referenceId = json['reference_id'];
    name = json['name'];
    amount = json['amount'];
    phone = json['phone'];
    status = json['status'];
    channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    ewallet =
        json['ewallet'] != null ? Ewallet.fromJson(json['ewallet']) : null;
    virtualAccount = json['virtual_account'] != null
        ? VirtualAccount.fromJson(json['virtual_account'])
        : null;
    qrCode = json['qr_code'] != null ? QrCode.fromJson(json['qr_code']) : null;
    otc = json['otc'] != null ? Otc.fromJson(json['otc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['reference_id'] = referenceId;
    data['name'] = name;
    data['amount'] = amount;
    data['phone'] = phone;
    data['status'] = status;
    if (channel != null) {
      data['channel'] = channel!.toJson();
    }
    if (ewallet != null) {
      data['ewallet'] = ewallet!.toJson();
    }
    if (virtualAccount != null) {
      data['virtual_account'] = virtualAccount!.toJson();
    }
    if (qrCode != null) {
      data['qr_code'] = qrCode!.toJson();
    }
    if (otc != null) {
      data['otc'] = otc!.toJson();
    }
    return data;
  }
}

class Channel {
  String? type;
  String? code;

  Channel({this.type, this.code});

  Channel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['code'] = code;
    return data;
  }
}

class Ewallet {
  String? deeplink;
  String? qrCode;

  Ewallet({this.deeplink, this.qrCode});

  Ewallet.fromJson(Map<String, dynamic> json) {
    deeplink = json['deeplink'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deeplink'] = deeplink;
    data['qr_code'] = qrCode;
    return data;
  }
}

class VirtualAccount {
  String? number;
  String? name;
  String? expiredAt;

  VirtualAccount({this.number, this.name, this.expiredAt});

  VirtualAccount.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    data['expired_at'] = expiredAt;
    return data;
  }
}

class QrCode {
  String? code;
  String? expiredAt;

  QrCode({this.code, this.expiredAt});

  QrCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['expired_at'] = expiredAt;
    return data;
  }
}

class Otc {
  String? code;
  String? name;
  String? expiredAt;

  Otc({this.code, this.name, this.expiredAt});

  Otc.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['expired_at'] = expiredAt;
    return data;
  }
}
