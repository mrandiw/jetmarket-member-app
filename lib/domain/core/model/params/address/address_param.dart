class AddressParam {
  const AddressParam({
    required this.page,
    required this.size,
    this.address,
    this.customerId,
  });

  final int page;
  final int size;
  final String? address;
  final int? customerId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'page': page,
      'size': size,
      'address': address,
      'customer_id': customerId,
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);

    return map;
  }
}
