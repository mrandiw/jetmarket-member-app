class PaymentParam {
  final String chType;
  final String chCode;
  final String amount;
  final String? mobileNumber;

  PaymentParam(
      {required this.chType,
      required this.chCode,
      required this.amount,
      this.mobileNumber});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'ch_type': chType,
      'ch_code': chCode,
      'amount': amount,
    };

    if (mobileNumber != null) {
      map['mobile_number'] = mobileNumber!;
    }

    return map;
  }
}
