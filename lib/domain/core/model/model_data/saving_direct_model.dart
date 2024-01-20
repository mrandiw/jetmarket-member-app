class SavingDirectModel {
  String? title;
  String? description;
  int? id;
  int? trxId;

  SavingDirectModel({this.title, this.description, this.id, this.trxId});

  SavingDirectModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
    trxId = json['trx_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['id'] = id;
    data['trx_id'] = trxId;
    return data;
  }
}
