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
  int? id;
  int? rating;
  String? review;
  List<String>? image;

  BodyDataReview({this.id, this.rating, this.review, this.image});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['review'] = review;
    data['images'] = image;
    data.removeWhere((key, value) => value == null || value == '');
    return data;
  }
}
