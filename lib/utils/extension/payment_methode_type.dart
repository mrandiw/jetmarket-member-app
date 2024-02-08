enum PaymentMethodeType { saving, register, topup, biling, order }

extension PaymentMethodeTypeExt on PaymentMethodeType {
  String get label {
    switch (this) {
      case PaymentMethodeType.saving:
        return 'SAV';
      case PaymentMethodeType.register:
        return 'REG';
      case PaymentMethodeType.topup:
        return 'TOP';
      case PaymentMethodeType.biling:
        return 'BIL';
      case PaymentMethodeType.order:
        return 'ORD';
      default:
        return 'SAV';
    }
  }
}
