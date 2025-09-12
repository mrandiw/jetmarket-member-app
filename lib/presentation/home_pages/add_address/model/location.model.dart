class LocationDataModel {
  final String label;
  final String address;
  final String posCode;
  final double lat;
  final double lng;

  LocationDataModel({
    required this.label,
    required this.address,
    required this.posCode,
    required this.lat,
    required this.lng,
  });

  /// Factory constructor untuk bikin object dari JSON
  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      label: json['label'] ?? '',
      address: json['address'] ?? '',
      posCode: json['pos_code'] ?? '',
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  /// Convert object ke JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'address': address,
      'pos_code': posCode,
      'lat': lat,
      'lng': lng,
    };
  }
}
