class LoanEntryParam {
  String? name;
  String? address;
  String? ktpNumber;
  String? ktpImage;
  String? bank;
  String? rekening;
  String? nameHolder;
  int? amount;

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
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
