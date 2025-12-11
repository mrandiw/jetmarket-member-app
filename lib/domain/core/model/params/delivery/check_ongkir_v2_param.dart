/// Parameter untuk check ongkir V2 dengan sistem tiered pricing
class CheckOngkirV2Param {
  int? addressId; // ID alamat customer
  int? sellerId; // ID seller/toko
  String? deliveryDate; // Tanggal pengiriman format "YYYY-MM-DD"

  CheckOngkirV2Param({
    this.addressId,
    this.sellerId,
    this.deliveryDate,
  });

  CheckOngkirV2Param.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    sellerId = json['seller_id'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['seller_id'] = sellerId;
    if (deliveryDate != null) {
      data['delivery_date'] = deliveryDate;
    }
    return data;
  }

  /// Validate parameter
  bool isValid() {
    return addressId != null &&
        addressId! > 0 &&
        sellerId != null &&
        sellerId! > 0;
  }

  /// Get error message if invalid
  String? getValidationError() {
    if (addressId == null || addressId! <= 0) {
      return 'Address ID tidak valid';
    }
    if (sellerId == null || sellerId! <= 0) {
      return 'Seller ID tidak valid';
    }
    return null;
  }
}
