class ChatModel {
  String? createdAt;
  int? id;
  String? image;
  String? deletedAt;
  int? fromId;
  String? readAt;
  int? toId;
  PinnedProduct? pinnedProduct;
  PinnedMessage? pinnedMessage;
  PinnedOrder? pinnedOrder;
  String? text;
  bool? fromStore;

  ChatModel(
      {this.createdAt,
      this.id,
      this.image,
      this.deletedAt,
      this.fromId,
      this.readAt,
      this.toId,
      this.pinnedProduct,
      this.pinnedMessage,
      this.pinnedOrder,
      this.text,
      this.fromStore});

  ChatModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    id = json['id'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    fromId = json['from_id'];
    readAt = json['read_at'];
    toId = json['to_id'];
    pinnedProduct = json['pinned_product'] != null
        ? PinnedProduct.fromJson(json['pinned_product'])
        : null;
    pinnedMessage = json['pinned_message'] != null
        ? PinnedMessage.fromJson(json['pinned_message'])
        : null;
    pinnedOrder = json['pinned_order'] != null
        ? PinnedOrder.fromJson(json['pinned_order'])
        : null;
    text = json['text'];
    fromStore = json['from_store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['from_id'] = fromId;
    data['read_at'] = readAt;
    data['to_id'] = toId;
    if (pinnedProduct != null) {
      data['pinned_product'] = pinnedProduct!.toJson();
    }
    if (pinnedMessage != null) {
      data['pinned_message'] = pinnedMessage!.toJson();
    }
    if (pinnedOrder != null) {
      data['pinned_order'] = pinnedOrder!.toJson();
    }
    data['text'] = text;
    data['from_store'] = fromStore;
    return data;
  }
}

class PinnedProduct {
  String? image;
  String? name;
  int? price;
  int? productId;
  int? promo;

  PinnedProduct(
      {this.image, this.name, this.price, this.productId, this.promo});

  PinnedProduct.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = json['price'];
    productId = json['product_id'];
    promo = json['promo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['product_id'] = productId;
    data['promo'] = promo;
    return data;
  }
}

class PinnedMessage {
  int? id;
  String? message;

  PinnedMessage({this.id, this.message});

  PinnedMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}

class PinnedOrder {
  String? address;
  int? addressId;
  int? customerId;
  String? customerName;
  int? lat;
  int? lng;
  int? orderId;
  String? status;

  PinnedOrder(
      {this.address,
      this.addressId,
      this.customerId,
      this.customerName,
      this.lat,
      this.lng,
      this.orderId,
      this.status});

  PinnedOrder.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressId = json['address_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    lat = json['lat'];
    lng = json['lng'];
    orderId = json['order_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['address_id'] = addressId;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['lat'] = lat;
    data['lng'] = lng;
    data['order_id'] = orderId;
    data['status'] = status;
    return data;
  }
}
