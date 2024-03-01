class LoanBillModel {
  int? amount;
  String? dueAt;
  int? id;
  String? refId;
  String? status;

  LoanBillModel({this.amount, this.dueAt, this.id, this.refId, this.status});

  LoanBillModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    dueAt = json['due_at'];
    id = json['id'];
    refId = json['ref_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['due_at'] = dueAt;
    data['id'] = id;
    data['ref_id'] = refId;
    data['status'] = status;
    return data;
  }
}
