class Profile_Parameters {
  int empId;
  int compId;
  String fcmToken;
  String lang;

  Profile_Parameters({this.empId, this.compId, this.fcmToken, this.lang});

  Profile_Parameters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    fcmToken = json['fcm_token'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['fcm_token'] = this.fcmToken;
    data['lang'] = this.lang;
    return data;
  }
}