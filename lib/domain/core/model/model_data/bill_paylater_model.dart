class BillPaylaterModel {
  int? id;
  int? orderId;
  String? orderRefId;
  String? refId;
  int? amount;
  String? dueAt;
  String? status;

  BillPaylaterModel(
      {this.id,
      this.orderId,
      this.refId,
      this.amount,
      this.dueAt,
      this.status});

  BillPaylaterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderRefId = json['order_ref_id'];
    refId = json['ref_id'];
    amount = json['amount'];
    dueAt = json['due_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['order_ref_id'] = orderRefId;
    data['ref_id'] = refId;
    data['amount'] = amount;
    data['due_at'] = dueAt;
    data['status'] = status;
    return data;
  }
}
