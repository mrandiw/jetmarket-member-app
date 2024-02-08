class RefferalModel {
  int? id;
  int? amount;
  String? downlineName;
  String? createdAt;

  RefferalModel({this.id, this.amount, this.downlineName, this.createdAt});

  RefferalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    downlineName = json['downline_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['downline_name'] = downlineName;
    data['created_at'] = createdAt;
    return data;
  }
}
