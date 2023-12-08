class PaymentParam {
  final String id;
  final String amount;
  final String? mobileNumber;

  PaymentParam({required this.id, required this.amount, this.mobileNumber});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'payment_method_id': id,
      'amount': amount,
    };

    if (mobileNumber != null) {
      map['mobile_number'] = mobileNumber!;
    }

    return map;
  }
}
