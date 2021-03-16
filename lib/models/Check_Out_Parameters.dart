class CheckOutParameters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  int shiftId;
  String transType;
  double transLong;
  double transLat;
  String workHours;
  String overtime;
  String totalHours;
  int attendTransId;

  CheckOutParameters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.shiftId,
      this.transType,
      this.transLong,
      this.transLat,
      this.workHours,
      this.overtime,
      this.totalHours,
      this.attendTransId});

  CheckOutParameters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    shiftId = json['shift_id'];
    transType = json['trans_type'];
    transLong = json['trans_long'];
    transLat = json['trans_lat'];
    workHours = json['work_hours'];
    overtime = json['overtime'];
    totalHours = json['total_hours'];
    attendTransId = json['attend_trans_id'];
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
    data['work_hours'] = this.workHours;
    data['overtime'] = this.overtime;
    data['total_hours'] = this.totalHours;
    data['attend_trans_id'] = this.attendTransId;
    return data;
  }
}