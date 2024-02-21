class NotificationData {
  String? body;
  String? createdAt;
  String? email;
  int? id;
  String? image;
  String? pagelink;
  String? readAt;
  String? role;
  String? title;
  String? type;
  String? path;
  int? pathId;
  String? refId;

  NotificationData(
      {this.body,
      this.createdAt,
      this.email,
      this.id,
      this.image,
      this.pagelink,
      this.readAt,
      this.role,
      this.title,
      this.type,
      this.path,
      this.pathId,
      this.refId});

  NotificationData.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    createdAt = json['created_at'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    pagelink = json['pagelink'];
    readAt = json['read_at'];
    role = json['role'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['created_at'] = createdAt;
    data['email'] = email;
    data['id'] = id;
    data['image'] = image;
    data['pagelink'] = pagelink;
    data['read_at'] = readAt;
    data['role'] = role;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
