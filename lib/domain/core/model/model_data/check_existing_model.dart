class CheckExistingModel {
  bool? isExist;
  Chat? chat;

  CheckExistingModel({this.isExist, this.chat});

  CheckExistingModel.fromJson(Map<String, dynamic> json) {
    isExist = json['is_exist'];
    chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_exist'] = isExist;
    if (chat != null) {
      data['chat'] = chat!.toJson();
    }
    return data;
  }
}

class Chat {
  int? id;
  bool? isClosed;
  String? image;
  String? name;
  String? createdAt;
  String? message;
  int? unreadCount;

  Chat(
      {this.id,
      this.isClosed,
      this.image,
      this.name,
      this.createdAt,
      this.message,
      this.unreadCount});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isClosed = json['is_closed'];
    image = json['image'];
    name = json['name'];
    createdAt = json['created_at'];
    message = json['message'];
    unreadCount = json['unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_closed'] = isClosed;
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['message'] = message;
    data['unread_count'] = unreadCount;
    return data;
  }
}
