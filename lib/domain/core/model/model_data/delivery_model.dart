class DeliveryModel {
  int? sellerId;
  List<Services>? services;

  DeliveryModel({this.sellerId, this.services});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? name;
  String? duration;
  int? rate;
  List<Packets>? packets;

  Services({this.name, this.duration, this.rate, this.packets});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    duration = json['duration'];
    rate = json['rate'];
    if (json['packets'] != null) {
      packets = <Packets>[];
      json['packets'].forEach((v) {
        packets!.add(Packets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['duration'] = duration;
    data['rate'] = rate;
    if (packets != null) {
      data['packets'] = packets!.map((v) => v.toJson()).toList();
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
