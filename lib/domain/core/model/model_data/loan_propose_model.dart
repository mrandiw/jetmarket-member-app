class LoanProposeModel {
  String? createdAt;
  int? id;
  Note? note;
  String? status;

  LoanProposeModel({this.createdAt, this.id, this.note, this.status});

  LoanProposeModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Note {
  String? description;
  String? title;

  Note({this.description, this.title});

  Note.fromJson(Map<String, dynamic> json) {
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
