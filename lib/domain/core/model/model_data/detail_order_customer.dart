class DetailOrderCustomer {
  int? id;
  int? trxId;
  String? trxRef;
  String? customerName;
  String? createdAt;
  String? expiredAt;
  String? status;
  Delivery? delivery;
  Address? address;
  List<Products>? products;
  PaymentMethod? paymentMethod;
  int? totalPrice;
  int? totalOngkir;
  int? totalAmount;

  DetailOrderCustomer(
      {this.id,
      this.trxId,
      this.trxRef,
      this.customerName,
      this.createdAt,
      this.expiredAt,
      this.status,
      this.delivery,
      this.address,
      this.products,
      this.paymentMethod,
      this.totalPrice,
      this.totalOngkir});

  DetailOrderCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxId = json['trx_id'];
    trxRef = json['trx_ref'];
    customerName = json['customer_name'];
    createdAt = json['created_at'];
    expiredAt = json['expired_at'];
    status = json['status'];
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    paymentMethod = json['payment_method'] != null
        ? PaymentMethod.fromJson(json['payment_method'])
        : null;
    totalPrice = json['total_price'];
    totalOngkir = json['total_ongkir'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trx_id'] = trxId;
    data['trx_ref'] = trxRef;
    data['customer_name'] = customerName;
    data['created_at'] = createdAt;
    data['expired_at'] = expiredAt;
    data['status'] = status;
    if (delivery != null) {
      data['delivery'] = delivery!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (paymentMethod != null) {
      data['payment_method'] = paymentMethod!.toJson();
    }
    data['total_price'] = totalPrice;
    data['total_ongkir'] = totalOngkir;
    data['total_amount'] = totalAmount;
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

class Address {
  int? id;
  int? customerId;
  String? address;
  double? lat;
  double? lng;
  int? posCode;
  String? label;
  String? note;
  String? personName;
  String? personPhone;
  bool? isMain;

  Address(
      {this.id,
      this.customerId,
      this.address,
      this.lat,
      this.lng,
      this.posCode,
      this.label,
      this.note,
      this.personName,
      this.personPhone,
      this.isMain});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    posCode = json['pos_code'];
    label = json['label'];
    note = json['note'];
    personName = json['person_name'];
    personPhone = json['person_phone'];
    isMain = json['is_main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['pos_code'] = posCode;
    data['label'] = label;
    data['note'] = note;
    data['person_name'] = personName;
    data['person_phone'] = personPhone;
    data['is_main'] = isMain;
    return data;
  }
}

class Products {
  int? variantId;
  String? name;
  String? image;
  int? price;
  int? quantity;

  Products({this.variantId, this.name, this.image, this.price, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variant_id'] = variantId;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}

class PaymentMethod {
  int? id;
  String? chType;
  String? chCode;
  String? name;
  String? createdAt;

  PaymentMethod({this.id, this.chType, this.chCode, this.name, this.createdAt});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chType = json['ch_type'];
    chCode = json['ch_code'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ch_type'] = chType;
    data['ch_code'] = chCode;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
