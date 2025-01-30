class SetRefundParam {
  int? id;
  BodySetRefund? body;
  SetRefundParam({this.id, this.body});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (body != null) {
      data['body'] = body?.toMap();
    }
    return data;
  }
}

class BodySetRefund {
  String? code;
  String? serviceName;
  String? serviceCode;
  int? rate;
  String? trackingId;

  BodySetRefund(
      {this.code,
      this.serviceName,
      this.serviceCode,
      this.rate,
      this.trackingId});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['service_name'] = serviceName;
    data['service_code'] = serviceCode;
    data['rate'] = rate;
    data['tracking_id'] = trackingId;
    return data;
  }
}
