class SavingDirectParam {
  int? amount;
  int? paymentMethodId;
  String? chCode;
  String? chType;

  SavingDirectParam(
      {this.amount, this.paymentMethodId, this.chCode, this.chType});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['payment_method_id'] = paymentMethodId;
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
