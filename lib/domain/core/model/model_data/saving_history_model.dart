class SavingHistoryModel {
  int? id;
  String? title;
  String? body;
  String? createdAt;

  SavingHistoryModel({this.id, this.title, this.body, this.createdAt});

  SavingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    return data;
  }
}
