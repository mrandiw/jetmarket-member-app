class AddressBody {
  const AddressBody({
    this.id,
    required this.customerId,
    required this.address,
    required this.lat,
    required this.lng,
    required this.label,
    required this.note,
    required this.personName,
    required this.personPhone,
    required this.posCode,
    required this.isMain,
  });

  final int? id;
  final int customerId;
  final String address;
  final double lat;
  final double lng;
  final String label;
  final String note;
  final String personName;
  final String personPhone;
  final int posCode;
  final bool isMain;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'customer_id': customerId,
      'address': address,
      'lat': lat,
      'lng': lng,
      'label': label,
      'note': note,
      'person_name': personName,
      'person_phone': personPhone,
      'pos_code': posCode,
      'is_main': isMain
    };
    map.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return map;
  }
}
