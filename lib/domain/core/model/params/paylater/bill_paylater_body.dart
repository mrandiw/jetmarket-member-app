class BillPaylaterBody {
  int? billId;
  int? amount;
  int? paymentMethodId;
  String? mobileNumber;

  BillPaylaterBody(
      {this.billId, this.amount, this.paymentMethodId, this.mobileNumber});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_id'] = billId;
    data['amount'] = amount;
    data['payment_method_id'] = paymentMethodId;
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
