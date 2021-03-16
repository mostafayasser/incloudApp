class CheckInParmeters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  int shiftId;
  String transType;
  double transLong;
  double transLat;

  CheckInParmeters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.shiftId,
      this.transType,
      this.transLong,
      this.transLat});

  CheckInParmeters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    shiftId = json['shift_id'];
    transType = json['trans_type'];
    transLong = json['trans_long'];
    transLat = json['trans_lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['shift_id'] = this.shiftId;
    data['trans_type'] = this.transType;
    data['trans_long'] = this.transLong;
    data['trans_lat'] = this.transLat;
    return data;
  }
}