class ReviewParam {
  int? id;
  List<BodyDataReview>? body;
  ReviewParam({this.id, this.body});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (body != null) {
      data['body'] = body!.map((bodyData) => bodyData.toMap()).toList();
    }
    return data;
  }
}

class BodyDataReview {
  int? orderItemId;
  int? productId;
  int? rating;
  String? review;
  List<String>? image;

  BodyDataReview(
      {this.orderItemId, this.productId, this.rating, this.review, this.image});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_item_id'] = orderItemId;
    data['product_id'] = productId;
    data['rating'] = rating;
    data['review'] = review;
    data['images'] = image;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
