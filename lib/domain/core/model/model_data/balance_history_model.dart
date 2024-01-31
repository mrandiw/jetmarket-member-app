class BalanceHistoryModel {
  int? amount;
  String? createdAt;
  String? description;
  int? id;
  String? refId;
  String? status;

  BalanceHistoryModel(
      {this.amount,
      this.createdAt,
      this.description,
      this.id,
      this.refId,
      this.status});

  BalanceHistoryModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    refId = json['ref_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id'] = id;
    data['ref_id'] = refId;
    data['status'] = status;
    return data;
  }
}
