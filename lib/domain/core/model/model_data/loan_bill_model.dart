class LoanBillModel {
  int? id;
  String? status;
  Note? note;
  String? createdAt;

  LoanBillModel({this.id, this.status, this.note, this.createdAt});

  LoanBillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Note {
  String? title;
  String? description;

  Note({this.title, this.description});

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
