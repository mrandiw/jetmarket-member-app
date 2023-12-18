class ProductSellerParam {
  const ProductSellerParam({
    required this.sellerId,
    required this.page,
    required this.size,
    this.name,
    this.sortBy,
    this.minRating,
    this.categoryId,
  });

  final int sellerId;
  final int page;
  final int size;
  final String? name;
  final String? sortBy;
  final double? minRating;
  final int? categoryId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'seller_id': sellerId,
      'page': page,
      'size': size,
      'name': name,
      'sort_by': sortBy,
      'min_rating': minRating,
      'category_id': categoryId,
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
