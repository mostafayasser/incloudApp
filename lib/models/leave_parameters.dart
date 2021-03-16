class LeavesParameters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  String leaveDate;
  String leaveTime;
  String missedTime;
  String leaveReason;

  LeavesParameters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.leaveDate,
      this.leaveTime,
      this.missedTime,
      this.leaveReason});

  LeavesParameters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    leaveDate = json['leave_date'];
    leaveTime = json['leave_time'];
    missedTime = json['missed_time'];
    leaveReason = json['leave_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['leave_date'] = this.leaveDate;
    data['leave_time'] = this.leaveTime;
    data['missed_time'] = this.missedTime;
    data['leave_reason'] = this.leaveReason;
    return data;
  }
}