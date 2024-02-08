class ChatModel {
  int? id;
  String? createdAt;
  String? image;
  String? readAt;
  String? deletedAt;
  bool? fromStore;
  PinnedMessage? pinnedMessage;
  PinnedOrder? pinnedOrder;
  PinnedProduct? pinnedProduct;
  Receiver? receiver;
  Sender? sender;
  String? text;

  ChatModel(
      {this.id,
      this.createdAt,
      this.image,
      this.readAt,
      this.deletedAt,
      this.fromStore,
      this.pinnedMessage,
      this.pinnedOrder,
      this.pinnedProduct,
      this.receiver,
      this.sender,
      this.text});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    image = json['image'];
    readAt = json['read_at'];
    deletedAt = json['deleted_at'];
    fromStore = json['from_store'];
    pinnedMessage = json['pinned_message'] != null
        ? PinnedMessage.fromJson(json['pinned_message'])
        : null;
    pinnedOrder = json['pinned_order'] != null
        ? PinnedOrder.fromJson(json['pinned_order'])
        : null;
    pinnedProduct = json['pinned_product'] != null
        ? PinnedProduct.fromJson(json['pinned_product'])
        : null;
    receiver =
        json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['image'] = image;
    data['read_at'] = readAt;
    data['deleted_at'] = deletedAt;
    if (pinnedMessage != null) {
      data['pinned_message'] = pinnedMessage!.toMap();
    }
    if (pinnedOrder != null) {
      data['pinned_order'] = pinnedOrder!.toMap();
    }
    if (pinnedProduct != null) {
      data['pinned_product'] = pinnedProduct!.toMap();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toMap();
    }
    if (sender != null) {
      data['sender'] = sender!.toMap();
    }
    data['text'] = text;
    data.removeWhere((key, value) =>
        value == null ||
        value == '' ||
        value == 0.0 ||
        value == 0 ||
        (value is Map && value.isEmpty));
    return data;
  }
}

class PinnedMessage {
  String? deletedAt;
  int? id;
  String? image;
  int? receiverId;
  String? receiverName;
  int? senderId;
  String? senderName;
  String? text;
  bool? isSender;
  String? role;

  PinnedMessage(
      {this.deletedAt,
      this.id,
      this.image,
      this.receiverId,
      this.receiverName,
      this.senderId,
      this.senderName,
      this.text,
      this.isSender,
      this.role});

  PinnedMessage.fromJson(Map<String, dynamic> json) {
    deletedAt = json['deleted_at'];
    id = json['id'];
    image = json['image'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    text = json['text'];
    role = json['role'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleted_at'] = deletedAt;
    data['id'] = id;
    data['image'] = image;
    data['receiver_id'] = receiverId;
    data['receiver_name'] = receiverName;
    data['sender_id'] = senderId;
    data['sender_name'] = senderName;
    data['text'] = text;
    data['role'] = role;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class PinnedOrder {
  String? address;
  int? addressId;
  int? customerId;
  String? customerName;
  double? lat;
  double? lng;
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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['address_id'] = addressId;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['lat'] = lat;
    data['lng'] = lng;
    data['order_id'] = orderId;
    data['status'] = status;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
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

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['product_id'] = productId;
    data['promo'] = promo;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class Receiver {
  int? id;
  String? image;
  String? name;
  String? role;

  Receiver({this.id, this.image, this.name, this.role});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['role'] = role;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class Sender {
  int? id;
  String? image;
  String? name;
  String? role;

  Sender({this.id, this.image, this.name, this.role});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['role'] = role;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
