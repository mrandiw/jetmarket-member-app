class ChatParam {
  const ChatParam(
      {required this.id,
      required this.chatIdStore,
      required this.page,
      required this.size});

  final int id;
  final String chatIdStore;
  final int page;
  final int size;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'id': id, 'page': page, 'size': size};
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
