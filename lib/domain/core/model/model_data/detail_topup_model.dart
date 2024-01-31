class DetailTopupModel {
  int? amount;
  String? createdAt;
  int? id;
  String? name;
  PinnedNote? pinnedNote;
  String? refId;
  String? status;
  String? updatedAt;

  DetailTopupModel(
      {this.amount,
      this.createdAt,
      this.id,
      this.name,
      this.pinnedNote,
      this.refId,
      this.status,
      this.updatedAt});

  DetailTopupModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    id = json['id'];
    name = json['name'];
    pinnedNote = json['pinned_note'] != null
        ? PinnedNote.fromJson(json['pinned_note'])
        : null;
    refId = json['ref_id'];
    status = json['status'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    if (pinnedNote != null) {
      data['pinned_note'] = pinnedNote!.toJson();
    }
    data['ref_id'] = refId;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PinnedNote {
  String? description;
  String? title;

  PinnedNote({this.description, this.title});

  PinnedNote.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['title'] = title;
    return data;
  }
}
