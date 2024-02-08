class TrackingOrderModel {
  int? step;
  List<DeliveryEntries>? deliveryEntries;

  TrackingOrderModel({this.step, this.deliveryEntries});

  TrackingOrderModel.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    if (json['delivery_entries'] != null) {
      deliveryEntries = <DeliveryEntries>[];
      json['delivery_entries'].forEach((v) {
        deliveryEntries!.add(DeliveryEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step'] = step;
    if (deliveryEntries != null) {
      data['delivery_entries'] =
          deliveryEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryEntries {
  String? title;
  String? createdAt;
  String? content;

  DeliveryEntries({this.title, this.createdAt, this.content});

  DeliveryEntries.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['created_at'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['created_at'] = createdAt;
    data['content'] = content;
    return data;
  }
}
