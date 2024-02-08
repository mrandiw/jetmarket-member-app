class DetailPaylaterModel {
  int? limit;
  int? total;
  Bill? bill;

  DetailPaylaterModel({this.limit, this.total, this.bill});

  DetailPaylaterModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    total = json['total'];
    bill = json['bill'] != null ? Bill.fromJson(json['bill']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['total'] = total;
    if (bill != null) {
      data['bill'] = bill!.toJson();
    }
    return data;
  }
}

class Bill {
  int? id;
  String? refId;
  int? amount;
  String? dueAt;
  String? status;

  Bill({this.id, this.refId, this.amount, this.dueAt, this.status});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    amount = json['amount'];
    dueAt = json['due_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    data['amount'] = amount;
    data['due_at'] = dueAt;
    data['status'] = status;
    return data;
  }
}
