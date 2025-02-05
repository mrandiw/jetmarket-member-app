class GeneralConfigModel {
  int? id;
  String? code;
  String? value;
  String? createdAt;

  GeneralConfigModel({this.id, this.code, this.value, this.createdAt});

  GeneralConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['value'] = value;
    data['created_at'] = createdAt;

    return data;
  }
}
