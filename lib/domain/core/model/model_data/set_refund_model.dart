class SetRefundModel {
  Address? address;
  List<RefundItems>? refundItems;
  List<Services>? services;

  SetRefundModel({this.address, this.refundItems, this.services});

  SetRefundModel.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['refund_items'] != null) {
      refundItems = <RefundItems>[];
      json['refund_items'].forEach((v) {
        refundItems!.add(RefundItems.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (refundItems != null) {
      data['refund_items'] = refundItems!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? address;
  String? label;
  int? posCode;
  String? shopName;
  String? shopPhone;

  Address(
      {this.address, this.label, this.posCode, this.shopName, this.shopPhone});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    label = json['label'];
    posCode = json['pos_code'];
    shopName = json['shop_name'];
    shopPhone = json['shop_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['label'] = label;
    data['pos_code'] = posCode;
    data['shop_name'] = shopName;
    data['shop_phone'] = shopPhone;
    return data;
  }
}

class RefundItems {
  String? image;
  int? price;
  int? quantity;
  String? title;
  int? variantId;

  RefundItems(
      {this.image, this.price, this.quantity, this.title, this.variantId});

  RefundItems.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    title = json['title'];
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    data['title'] = title;
    data['variant_id'] = variantId;
    return data;
  }
}

class Services {
  String? duration;
  String? name;
  List<Packets>? packets;
  int? rate;

  Services({this.duration, this.name, this.packets, this.rate});

  Services.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    name = json['name'];
    if (json['packets'] != null) {
      packets = <Packets>[];
      json['packets'].forEach((v) {
        packets!.add(Packets.fromJson(v));
      });
    }
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['name'] = name;
    if (packets != null) {
      data['packets'] = packets!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    return data;
  }
}

class Packets {
  Delivery? delivery;
  String? duration;
  String? name;
  int? rate;

  Packets({this.delivery, this.duration, this.name, this.rate});

  Packets.fromJson(Map<String, dynamic> json) {
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
    duration = json['duration'];
    name = json['name'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (delivery != null) {
      data['delivery'] = delivery!.toJson();
    }
    data['duration'] = duration;
    data['name'] = name;
    data['rate'] = rate;
    return data;
  }
}

class Delivery {
  String? code;
  int? rate;
  String? serviceCode;
  String? serviceName;

  Delivery({this.code, this.rate, this.serviceCode, this.serviceName});

  Delivery.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    rate = json['rate'];
    serviceCode = json['service_code'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['rate'] = rate;
    data['service_code'] = serviceCode;
    data['service_name'] = serviceName;
    return data;
  }
}
