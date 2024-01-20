class SavingInstallmentParam {
  String? dueAt;
  int? amount;

  SavingInstallmentParam({this.dueAt, this.amount});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['due_at'] = dueAt;
    data['amount'] = amount;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
