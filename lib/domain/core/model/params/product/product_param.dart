class ProductParam {
  const ProductParam({
    required this.page,
    required this.size,
    this.sortBy,
    this.minRating,
    this.categoryId,
  });

  final int page;
  final int size;
  final String? sortBy;
  final int? minRating;
  final int? categoryId;

  Map<String, dynamic> toMap() => {
        'page': page,
        'size': size,
        'sort_by': sortBy ?? '',
        'min_rating': minRating ?? 0,
        'category_id': categoryId ?? 0,
      };
}
