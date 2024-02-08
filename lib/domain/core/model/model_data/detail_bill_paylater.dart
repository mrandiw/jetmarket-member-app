class DetailBillPaylater {
  Address? address;
  String? createdAt;
  String? customerName;
  Delivery? delivery;
  int? id;
  PaymentMethod? paymentMethod;
  List<Products>? products;
  String? refId;
  String? status;
  int? totalAmount;
  int? totalOngkir;
  int? totalPrice;

  DetailBillPaylater(
      {this.address,
      this.createdAt,
      this.customerName,
      this.delivery,
      this.id,
      this.paymentMethod,
      this.products,
      this.refId,
      this.status,
      this.totalAmount,
      this.totalOngkir,
      this.totalPrice});

  DetailBillPaylater.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    createdAt = json['created_at'];
    customerName = json['customer_name'];
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
    id = json['id'];
    paymentMethod = json['payment_method'] != null
        ? PaymentMethod.fromJson(json['payment_method'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    refId = json['ref_id'];
    status = json['status'];
    totalAmount = json['total_amount'];
    totalOngkir = json['total_ongkir'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['created_at'] = createdAt;
    data['customer_name'] = customerName;
    if (delivery != null) {
      data['delivery'] = delivery!.toJson();
    }
    data['id'] = id;
    if (paymentMethod != null) {
      data['payment_method'] = paymentMethod!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['ref_id'] = refId;
    data['status'] = status;
    data['total_amount'] = totalAmount;
    data['total_ongkir'] = totalOngkir;
    data['total_price'] = totalPrice;
    return data;
  }
}

class Address {
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

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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

class PaymentMethod {
  String? chCode;
  String? chType;
  String? createdAt;
  int? id;
  String? name;

  PaymentMethod({this.chCode, this.chType, this.createdAt, this.id, this.name});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    chCode = json['ch_code'];
    chType = json['ch_type'];
    createdAt = json['created_at'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ch_code'] = chCode;
    data['ch_type'] = chType;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Products {
  int? id;
  String? image;
  String? name;
  String? note;
  int? price;
  int? quantity;
  int? variantId;

  Products(
      {this.id,
      this.image,
      this.name,
      this.note,
      this.price,
      this.quantity,
      this.variantId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    note = json['note'];
    price = json['price'];
    quantity = json['quantity'];
    variantId = json['variant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['note'] = note;
    data['price'] = price;
    data['quantity'] = quantity;
    data['variant_id'] = variantId;
    return data;
  }
}
