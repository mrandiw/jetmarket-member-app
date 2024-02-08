class DetailWithdrawModel {
  int? id;
  PinnedNote? pinnedNote;
  UserData? userData;
  WithdrawData? withdrawData;
  String? status;

  DetailWithdrawModel(
      {this.id,
      this.pinnedNote,
      this.userData,
      this.withdrawData,
      this.status});

  DetailWithdrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pinnedNote = json['pinned_note'] != null
        ? PinnedNote.fromJson(json['pinned_note'])
        : null;
    userData =
        json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    withdrawData = json['withdraw_data'] != null
        ? WithdrawData.fromJson(json['withdraw_data'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (pinnedNote != null) {
      data['pinned_note'] = pinnedNote!.toJson();
    }
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    if (withdrawData != null) {
      data['withdraw_data'] = withdrawData!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class PinnedNote {
  String? title;
  String? description;

  PinnedNote({this.title, this.description});

  PinnedNote.fromJson(Map<String, dynamic> json) {
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

class UserData {
  int? id;
  String? role;
  String? name;

  UserData({this.id, this.role, this.name});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['name'] = name;
    return data;
  }
}

class WithdrawData {
  String? createdAt;
  String? updatedAt;
  int? amount;
  String? rekening;
  String? bank;

  WithdrawData(
      {this.createdAt, this.updatedAt, this.amount, this.rekening, this.bank});

  WithdrawData.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    rekening = json['rekening'];
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['amount'] = amount;
    data['rekening'] = rekening;
    data['bank'] = bank;
    return data;
  }
}
