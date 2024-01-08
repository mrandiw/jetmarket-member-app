class OrderCustomerModel {
  int? addressId;
  int? voucherId;
  String? mobileNumber;
  int? totalAmount;
  int? paymentMethodId;
  List<Items>? items;

  OrderCustomerModel(
      {this.addressId,
      this.voucherId,
      this.mobileNumber,
      this.totalAmount,
      this.paymentMethodId,
      this.items});

  OrderCustomerModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    voucherId = json['voucher_id'];
    mobileNumber = json['mobile_number'];
    totalAmount = json['total_amount'];
    paymentMethodId = json['payment_method_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['voucher_id'] = voucherId;
    data['mobile_number'] = mobileNumber;
    data['total_amount'] = totalAmount;
    data['payment_method_id'] = paymentMethodId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class Items {
  int? sellerId;
  List<Products>? products;
  Delivery? delivery;

  Items({this.sellerId, this.products, this.delivery});

  Items.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    delivery =
        json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (delivery != null) {
      data['delivery'] = delivery!.toJson();
    }
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class Products {
  String? productName;
  int? variantId;
  int? price;
  int? quantity;

  Products({this.productName, this.variantId, this.price, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    variantId = json['variant_id'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_name'] = productName;
    data['variant_id'] = variantId;
    data['price'] = price;
    data['quantity'] = quantity;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
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
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
