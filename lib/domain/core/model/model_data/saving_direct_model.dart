class SavingDirectModel {
  String? title;
  String? description;
  int? savingId;

  SavingDirectModel({this.title, this.description, this.savingId});

  SavingDirectModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    savingId = json['saving_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['saving_id'] = savingId;
    return data;
  }
}
