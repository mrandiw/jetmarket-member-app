class SendWithdrawBody {
  String? nameHolder;
  String? bank;
  String? chCode;
  String? rekening;
  int? amount;

  SendWithdrawBody(
      {this.nameHolder, this.bank, this.chCode, this.rekening, this.amount});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_holder'] = nameHolder;
    data['bank'] = bank;
    data['ch_code'] = chCode;
    data['rekening'] = rekening;
    data['amount'] = amount;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
