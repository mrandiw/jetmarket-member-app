class LoanProposeListParam {
  const LoanProposeListParam(
      {required this.page, required this.size, this.sortBy});

  final int page;
  final int size;
  final String? sortBy;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'page': page, 'size': size, 'sort_by': sortBy};
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
