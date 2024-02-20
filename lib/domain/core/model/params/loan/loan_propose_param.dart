class LoanProposeParam {
  String? name;
  String? address;
  String? ktpNumber;
  String? ktpImage;
  String? bank;
  String? rekening;
  String? nameHolder;
  int? amount;
  int? tenor;

  LoanProposeParam(
      {this.name,
      this.address,
      this.ktpNumber,
      this.ktpImage,
      this.bank,
      this.rekening,
      this.nameHolder,
      this.amount,
      this.tenor});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['ktp_number'] = ktpNumber;
    data['ktp_image'] = ktpImage;
    data['bank'] = bank;
    data['rekening'] = rekening;
    data['name_holder'] = nameHolder;
    data['amount'] = amount;
    data['tenor'] = tenor;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
