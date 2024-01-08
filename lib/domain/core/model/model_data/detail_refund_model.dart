class DetailRefundModel {
  Note? note;
  Seller? seller;
  List<RefundItems>? refundItems;
  int? totalAmount;
  String? approvedAt;
  List<Proofs>? proofs;

  DetailRefundModel(
      {this.note,
      this.seller,
      this.refundItems,
      this.totalAmount,
      this.approvedAt,
      this.proofs});

  DetailRefundModel.fromJson(Map<String, dynamic> json) {
    note = json['note'] != null ? Note.fromJson(json['note']) : null;
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    if (json['refund_items'] != null) {
      refundItems = <RefundItems>[];
      json['refund_items'].forEach((v) {
        refundItems!.add(RefundItems.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    approvedAt = json['approved_at'];
    if (json['proofs'] != null) {
      proofs = <Proofs>[];
      json['proofs'].forEach((v) {
        proofs!.add(Proofs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (note != null) {
      data['note'] = note!.toJson();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    if (refundItems != null) {
      data['refund_items'] = refundItems!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['approved_at'] = approvedAt;
    if (proofs != null) {
      data['proofs'] = proofs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Note {
  String? title;
  String? description;

  Note({this.title, this.description});

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class Seller {
  int? id;
  String? shopName;
  String? status;
  String? address;
  String? image;
  double? lat;
  double? lng;
  int? posCode;
  String? phone;
  String? email;

  Seller(
      {this.id,
      this.shopName,
      this.status,
      this.address,
      this.image,
      this.lat,
      this.lng,
      this.posCode,
      this.phone,
      this.email});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    status = json['status'];
    address = json['address'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    posCode = json['pos_code'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_name'] = shopName;
    data['status'] = status;
    data['address'] = address;
    data['image'] = image;
    data['lat'] = lat;
    data['lng'] = lng;
    data['pos_code'] = posCode;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}

class RefundItems {
  String? image;
  String? name;
  int? price;
  int? quantity;

  RefundItems({this.image, this.name, this.price, this.quantity});

  RefundItems.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}

class Proofs {
  String? description;
  String? image;

  Proofs({this.description, this.image});

  Proofs.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
