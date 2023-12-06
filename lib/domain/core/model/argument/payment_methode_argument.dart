class PaymentMethodeArgument {
  final int id;
  final String amount;
  final String? mobileNumber;
  final String chType;
  final String chCode;
  final String name;

  PaymentMethodeArgument(
      {required this.id,
      required this.amount,
      this.mobileNumber,
      required this.chType,
      required this.chCode,
      required this.name});
}
