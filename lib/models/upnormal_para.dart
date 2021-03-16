class UpnormalParameters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  String upnormalLong;
  String upnormalLat;
  String away;

  UpnormalParameters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.upnormalLong,
      this.upnormalLat,
      this.away});

  UpnormalParameters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    upnormalLong = json['upnormal_long'];
    upnormalLat = json['upnormal_lat'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['upnormal_long'] = this.upnormalLong;
    data['upnormal_lat'] = this.upnormalLat;
    data['away'] = this.away;
    return data;
  }
}
