
class ChangesParameters {
  int empId;
  int compId;
  String newPass;
  String oldPass;
  String lang;
  String fcmToken;
  bool firstLogin;

  ChangesParameters(
      {this.empId,
      this.compId,
      this.newPass,
      this.oldPass,
      this.lang,
      this.fcmToken,
      this.firstLogin});

  ChangesParameters.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    newPass = json['new_pass'];
    oldPass = json['old_pass'];
    lang = json['lang'];
    fcmToken = json['fcm_token'];
    firstLogin = json['first_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['comp_id'] = this.compId;
    data['new_pass'] = this.newPass;
    data['old_pass'] = this.oldPass;
    data['lang'] = this.lang;
    data['fcm_token'] = this.fcmToken;
    data['first_login'] = this.firstLogin;
    return data;
  }
}

