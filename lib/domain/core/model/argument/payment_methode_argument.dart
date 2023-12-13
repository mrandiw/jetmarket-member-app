import '../model_data/payment_customer_model.dart';

class PaymentMethodeArgument {
  final int? id;
  final int? trxId;
  final String? status;
  final String? amount;
  final String? mobileNumber;
  final String? chType;
  final String? chCode;
  final String? name;
  final PaymentCustomerModel? data;

  PaymentMethodeArgument(
      {this.id,
      this.trxId,
      this.status,
      this.amount,
      this.mobileNumber,
      this.chType,
      this.chCode,
      this.name,
      this.data});
}
