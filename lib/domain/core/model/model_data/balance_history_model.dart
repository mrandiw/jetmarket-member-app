class BalanceHistoryModel {
  int? id;
  String? refId;
  String? description;
  String? createdAt;
  int? amount;

  BalanceHistoryModel(
      {this.id, this.refId, this.description, this.createdAt, this.amount});

  BalanceHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    description = json['description'];
    createdAt = json['created_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['amount'] = amount;
    return data;
  }
}
