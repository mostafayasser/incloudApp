class UserSigned {
  String status;
  String message;
  Data data;
  bool first_login;

  UserSigned({this.status, this.message, this.data, this.first_login});

  UserSigned.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    first_login = json["first_login"];
    data = (json['data'] != null || json['data'] != "")
        ? (json['data'] == "")
            ? null
            : new Data.fromJson(json['data'])
        : null;
  }
}

class Data {
  int empId;
  int compId;
  String fcmToken;
  bool first_login;

  Data({this.empId, this.compId, this.fcmToken,this.first_login});

  Data.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    compId = json['comp_id'];
    fcmToken = json['fcm_token'];
    first_login = json["first_login"];
  }
}
