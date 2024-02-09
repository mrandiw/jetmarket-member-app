class ChatUpdateParam {
  int? chatId;
  String? senderName;
  String? message;

  ChatUpdateParam({this.chatId, this.senderName, this.message});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    data['sender_name'] = senderName;
    data['message'] = message;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
