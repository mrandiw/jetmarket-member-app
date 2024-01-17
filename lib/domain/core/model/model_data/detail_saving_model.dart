class DetailSavingModel {
  int? amount;
  String? createdAt;
  int? id;
  String? noteBody;
  String? noteTitle;
  String? status;
  int? totalAmount;

  DetailSavingModel(
      {this.amount,
      this.createdAt,
      this.id,
      this.noteBody,
      this.noteTitle,
      this.status,
      this.totalAmount});

  DetailSavingModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['created_at'];
    id = json['id'];
    noteBody = json['note_body'];
    noteTitle = json['note_title'];
    status = json['status'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['note_body'] = noteBody;
    data['note_title'] = noteTitle;
    data['status'] = status;
    data['total_amount'] = totalAmount;
    return data;
  }
}
