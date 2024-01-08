class OrderCustomerBody {
  int? addressId;
  int? voucherId;
  String? mobileNumber;
  num? totalAmount;
  int? paymentMethodId;
  List<Items>? items;

  OrderCustomerBody(
      {this.addressId,
      this.voucherId,
      this.mobileNumber,
      this.totalAmount,
      this.paymentMethodId,
      this.items});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['voucher_id'] = voucherId;
    data['mobile_number'] = mobileNumber;
    data['total_amount'] = totalAmount;
    data['payment_method_id'] = paymentMethodId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toMap()).toList();
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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toMap()).toList();
    }
    if (delivery != null) {
      data['delivery'] = delivery!.toMap();
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

  Map<String, dynamic> toMap() {
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

  Map<String, dynamic> toMap() {
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
