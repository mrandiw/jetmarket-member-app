class RefundParam {
  int? id;
  BodyRefundParam? body;
  RefundParam({this.id, this.body});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (body != null) {
      data['body'] = body?.toMap();
    }
    return data;
  }
}

class BodyRefundParam {
  List<int>? itemIds;
  String? reason;
  List<Proofs>? proofs;
  bool? requestReturn;

  BodyRefundParam({this.itemIds, this.reason, this.proofs, this.requestReturn});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_ids'] = itemIds;
    data['reason'] = reason;
    if (proofs != null) {
      data['proofs'] = proofs!.map((v) => v.toMap()).toList();
    }
    data['request_return'] = requestReturn;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}

class Proofs {
  String? image;
  String? description;

  Proofs({this.image, this.description});

  Proofs.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['description'] = description;
    data.removeWhere((key, value) =>
        value == null || value == '' || value == 0.0 || value == 0);
    return data;
  }
}
