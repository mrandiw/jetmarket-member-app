class DetailLoanBillModel {
  int? id;
  String? status;
  Note? note;
  Member? member;
  Loan? loan;

  DetailLoanBillModel(
      {this.id, this.status, this.note, this.member, this.loan});

  DetailLoanBillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    loan = json['loan'] != null ? Loan.fromJson(json['loan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    if (note != null) {
      data['note'] = note!.toJson();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (loan != null) {
      data['loan'] = loan!.toJson();
    }
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

class Member {
  int? id;
  String? name;
  String? address;
  String? ktpNumber;

  Member({this.id, this.name, this.address, this.ktpNumber});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    ktpNumber = json['ktp_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['ktp_number'] = ktpNumber;
    return data;
  }
}

class Loan {
  String? createdAt;
  String? dueAt;
  int? bill;
  int? totalAmount;
  int? count;
  int? totalCount;

  Loan(
      {this.createdAt,
      this.dueAt,
      this.bill,
      this.totalAmount,
      this.count,
      this.totalCount});

  Loan.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    dueAt = json['due_at'];
    bill = json['bill'];
    totalAmount = json['total_amount'];
    count = json['count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['due_at'] = dueAt;
    data['bill'] = bill;
    data['total_amount'] = totalAmount;
    data['count'] = count;
    data['total_count'] = totalCount;
    return data;
  }
}
