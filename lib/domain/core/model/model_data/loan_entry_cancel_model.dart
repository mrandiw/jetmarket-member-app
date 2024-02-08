class DetailLoanModel {
  int? id;
  String? status;
  Note? note;
  Member? member;
  Loan? loan;

  DetailLoanModel({this.id, this.status, this.note, this.member, this.loan});

  DetailLoanModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? createdAt;
  int? amount;

  Loan({this.id, this.createdAt, this.amount});

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['amount'] = amount;
    return data;
  }
}
