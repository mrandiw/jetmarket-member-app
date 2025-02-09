class AppVersionModel {
  int? id;
  String? typeApp;
  String? version;
  String? link;
  String? updateType;
  String? note;

  AppVersionModel(
      {this.id,
      this.typeApp,
      this.version,
      this.link,
      this.updateType,
      this.note});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeApp = json['type_app'];
    version = json['version'];
    link = json['link'];
    updateType = json['update_type'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_app'] = typeApp;
    data['version'] = version;
    data['link'] = link;
    data['update_type'] = updateType;
    data['note'] = note;
    return data;
  }
}
