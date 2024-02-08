class WalletTopupBody {
  String? chType;
  String? chCode;
  int? amount;
  String? mobileNumber;

  WalletTopupBody({this.chType, this.chCode, this.amount, this.mobileNumber});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ch_type'] = chType;
    data['ch_code'] = chCode;
    data['amount'] = amount;
    data['mobile_number'] = mobileNumber;
    data.removeWhere((key, value) =>
        value == null ||
        value == '' ||
        value == 0.0 ||
        value == 0 ||
        value == '+62');
    return data;
  }
}
