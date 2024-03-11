class LoanBillCheckModel {
  int? id;
  String? refId;
  int? amount;
  String? dueAt;
  String? status;

  LoanBillCheckModel(
      {this.id, this.refId, this.amount, this.dueAt, this.status});

  LoanBillCheckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    amount = json['amount'];
    dueAt = json['due_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['amount'] = amount;
    data['due_at'] = dueAt;
    data['status'] = status;
    return data;
  }
}
