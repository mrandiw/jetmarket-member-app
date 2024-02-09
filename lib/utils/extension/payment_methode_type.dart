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

extension PaymentMethodeTypeExtStr on String {
  PaymentMethodeType get paymentMethodeType {
    switch (this) {
      case 'SAV':
        return PaymentMethodeType.saving;
      case 'REG':
        return PaymentMethodeType.register;
      case 'TOP':
        return PaymentMethodeType.topup;
      case 'BIL':
        return PaymentMethodeType.biling;
      case 'ORD':
        return PaymentMethodeType.order;
      default:
        return PaymentMethodeType.saving;
    }
  }
}
