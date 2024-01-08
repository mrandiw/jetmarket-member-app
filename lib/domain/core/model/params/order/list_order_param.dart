class ListOrderParam {
  const ListOrderParam({
    required this.page,
    required this.size,
    this.sort,
    this.name,
    this.status,
  });

  final int page;
  final int size;
  final String? sort;
  final String? name;
  final String? status;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
      'sort': sort,
      'name': name,
      'status': status
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
