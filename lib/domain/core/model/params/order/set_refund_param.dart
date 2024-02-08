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

  BodySetRefund({this.code, this.serviceName, this.serviceCode, this.rate});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['service_name'] = serviceName;
    data['service_code'] = serviceCode;
    data['rate'] = rate;
    return data;
  }
}
