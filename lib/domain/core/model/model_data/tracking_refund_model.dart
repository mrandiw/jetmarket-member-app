class TrackingRefundModel {
  int? step;
  List<Histories>? histories;

  TrackingRefundModel({this.step, this.histories});

  TrackingRefundModel.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    if (json['histories'] != null) {
      histories = <Histories>[];
      json['histories'].forEach((v) {
        histories!.add(Histories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step'] = step;
    if (histories != null) {
      data['histories'] = histories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Histories {
  String? title;
  String? createdAt;
  String? content;

  Histories({this.title, this.createdAt, this.content});

  Histories.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['created_at'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['created_at'] = createdAt;
    data['content'] = content;
    return data;
  }
}
