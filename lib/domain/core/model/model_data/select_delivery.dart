class SelectDelivery {
  int? sellerId;
  Packets? packets;

  SelectDelivery({this.sellerId, this.packets});

  SelectDelivery.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    packets =
        json['packets'] != null ? Packets.fromJson(json['packets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    if (packets != null) {
      data['packets'] = packets!.toJson();
    }
    return data;
  }
}

class Packets {
  String? name;
  String? duration;
  int? rate;
  Delivery? delivery;

  Packets({this.name, this.duration, this.rate, this.delivery});

  Packets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    duration = json['duration'];
    rate = json['rate'];
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['duration'] = duration;
    data['rate'] = rate;
    if (delivery != null) {
      data['delivery'] = delivery!.toJson();
    }
    return data;
  }
}

class Delivery {
  String? code;
  String? serviceName;
  String? serviceCode;
  int? rate;

  Delivery({this.code, this.serviceName, this.serviceCode, this.rate});

  Delivery.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    serviceName = json['service_name'];
    serviceCode = json['service_code'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['service_name'] = serviceName;
    data['service_code'] = serviceCode;
    data['rate'] = rate;
    return data;
  }
}
