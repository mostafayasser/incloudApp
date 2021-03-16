class RequestParameters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  String vacType;
  String startDate;
  String endDate;
  int noOfDays;
  String reason;

  RequestParameters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.vacType,
      this.startDate,
      this.endDate,
      this.noOfDays,
      this.reason});

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['vac_type'] = this.vacType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['no_of_days'] = this.noOfDays;
    data['reason'] = this.reason;
    return data;
  }
}