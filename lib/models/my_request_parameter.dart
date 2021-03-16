class MyRequestParameters {
  int empId;
  int compId;
  String lang;
  String fcmToken;
  String year;
  String month;

  MyRequestParameters(
      {this.empId,
      this.compId,
      this.lang,
      this.fcmToken,
      this.year,
      this.month});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['year'] = this.year;
    data['month'] = this.month;
    return data;
  }
}