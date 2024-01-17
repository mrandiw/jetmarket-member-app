class SavingInstallmentParam {
  String? scheduledAt;
  int? amount;

  SavingInstallmentParam({this.scheduledAt, this.amount});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduled_at'] = scheduledAt;
    data['amount'] = amount;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
