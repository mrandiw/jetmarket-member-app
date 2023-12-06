class PaymentParam {
  final int id;
  final String amount;
  final String? mobileNumber;

  PaymentParam({required this.id, required this.amount, this.mobileNumber});

  Map<String, dynamic> toMap() => {
        'payment_method_id': id,
        'amount': amount,
        'mobile_number': mobileNumber,
      };
}
