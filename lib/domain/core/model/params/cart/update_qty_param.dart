class UpdateQtyParam {
  const UpdateQtyParam({
    required this.id,
    required this.qty,
  });

  final int id;
  final int qty;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'id': id, 'qty': qty};
    return map;
  }
}
