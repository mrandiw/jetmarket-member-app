class LoanBillParam {
  String? refId;
  int? amount;
  String? chCode;
  String? chType;
  String? mobileNumber;

  LoanBillParam({
    this.refId,
    this.amount,
    this.chCode,
    this.chType,
    this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ref_id'] = refId;
    data['amount'] = amount;
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    data['mobile_number'] = mobileNumber;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
