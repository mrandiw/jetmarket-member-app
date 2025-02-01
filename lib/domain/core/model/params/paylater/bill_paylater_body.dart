class BillPaylaterBody {
  String? refId;
  int? amount;
  String? chType;
  String? chCode;
  String? mobileNumber;

  BillPaylaterBody(
      {this.refId, this.amount, this.chType, this.chCode, this.mobileNumber});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (refId != null) data['ref_id'] = refId;
    data['amount'] = amount;
    if (chType != null) data['ch_type'] = chType;
    if (chCode != null) data['ch_code'] = chCode;
    if (mobileNumber != null) data['mobile_number'] = mobileNumber;
    data.removeWhere((key, value) =>
        value == null ||
        value == '' ||
        value == 0.0 ||
        value == 0 ||
        value == '+62');
    return data;
  }
}
