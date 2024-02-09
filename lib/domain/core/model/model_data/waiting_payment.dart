class WaitingPaymentModel {
  int? id;
  String? refId;
  String? expiredAt;
  PaymentInfo? paymentInfo;
  int? amount;

  WaitingPaymentModel(
      {this.id, this.refId, this.expiredAt, this.paymentInfo, this.amount});

  WaitingPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    expiredAt = json['expired_at'];
    paymentInfo = json['payment_info'] != null
        ? PaymentInfo.fromJson(json['payment_info'])
        : null;
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['expired_at'] = expiredAt;
    if (paymentInfo != null) {
      data['payment_info'] = paymentInfo!.toJson();
    }
    data['amount'] = amount;
    return data;
  }
}

class PaymentInfo {
  String? name;
  String? code;

  PaymentInfo({this.name, this.code});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
