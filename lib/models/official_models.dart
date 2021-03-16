class Official {
  int empId;
  int compId;
  String year;
  String lang;
  String fcmToken;

  Official({this.empId, this.compId, this.year, this.lang, this.fcmToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['year'] = this.year;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}