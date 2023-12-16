class NotificationParam {
  const NotificationParam({required this.page, required this.size});

  final int page;
  final int size;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'page': page, 'size': size, 'role': 'customer'};
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
