class NotificationData {
  String? body;
  String? createdAt;
  String? email;
  int? id;
  String? image;
  String? pagelink;
  String? role;
  String? title;
  String? type;

  NotificationData(
      {this.body,
      this.createdAt,
      this.email,
      this.id,
      this.image,
      this.pagelink,
      this.role,
      this.title,
      this.type});

  NotificationData.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    createdAt = json['created_at'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    pagelink = json['pagelink'];
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
    data['role'] = role;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
