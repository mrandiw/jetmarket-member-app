class AddressModel {
  String? address;
  int? customerId;
  int? id;
  bool? isMain;
  String? label;
  double? lat;
  double? lng;
  String? note;
  String? personName;
  String? personPhone;
  int? posCode;

  AddressModel(
      {this.address,
      this.customerId,
      this.id,
      this.isMain,
      this.label,
      this.lat,
      this.lng,
      this.note,
      this.personName,
      this.personPhone,
      this.posCode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    customerId = json['customer_id'];
    id = json['id'];
    isMain = json['is_main'];
    label = json['label'];
    lat = json['lat'];
    lng = json['lng'];
    note = json['note'];
    personName = json['person_name'];
    personPhone = json['person_phone'];
    posCode = json['pos_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['customer_id'] = customerId;
    data['id'] = id;
    data['is_main'] = isMain;
    data['label'] = label;
    data['lat'] = lat;
    data['lng'] = lng;
    data['note'] = note;
    data['person_name'] = personName;
    data['person_phone'] = personPhone;
    data['pos_code'] = posCode;
    return data;
  }
}
