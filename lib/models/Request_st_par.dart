class RequestStatPar {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  String requestType;
  String requestId;

  RequestStatPar(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.requestType,
      this.requestId});

  RequestStatPar.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    requestType = json['request_type'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['request_type'] = this.requestType;
    data['request_id'] = this.requestId;
    return data;
  }
}