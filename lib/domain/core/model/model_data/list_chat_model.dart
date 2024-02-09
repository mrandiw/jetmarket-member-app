class ListChatModel {
  int? id;
  bool? isClosed;
  String? image;
  String? name;
  String? createdAt;
  String? message;
  int? unreadCount;
  String? updatedAt;

  ListChatModel(
      {this.id,
      this.isClosed,
      this.image,
      this.name,
      this.createdAt,
      this.message,
      this.unreadCount,
      this.updatedAt});

  ListChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isClosed = json['is_closed'];
    image = json['image'];
    name = json['name'];
    createdAt = json['created_at'];
    message = json['message'];
    unreadCount = json['unread_count'];
    updatedAt = json['updated_at'];
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
    data['updated_at'] = updatedAt;
    return data;
  }
}
