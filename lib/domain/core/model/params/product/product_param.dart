class ProductParam {
  const ProductParam({
    required this.page,
    required this.size,
    this.sortBy,
    this.name,
    this.minRating,
    this.categoryId,
  });

  final int page;
  final int size;
  final String? sortBy;
  final String? name;
  final double? minRating;
  final int? categoryId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
      'sort_by': sortBy,
      'name': name,
      'min_rating': minRating,
      'category_id': categoryId,
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
