class SalariesPar {
  int empId;
  int compId;
  int year;
  int month;
  String fcmToken;
  String lang;

  SalariesPar(
      {this.empId,
      this.compId,
      this.year,
      this.month,
      this.fcmToken,
      this.lang});

  SalariesPar.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    year = json['year'];
    month = json['month'];
    fcmToken = json['fcm_token'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['year'] = this.year;
    data['month'] = this.month;
    data['fcm_token'] = this.fcmToken;
    data['lang'] = this.lang;
    return data;
  }
}