class AttendsCheck {
  String status;
  String message;
  Data data;

  AttendsCheck({this.status, this.message, this.data});

  AttendsCheck.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null || json['data'] != "")
        ? (json['data'] == "")
            ? null
            : new Data.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int attendId;

  Data({this.attendId});

  Data.fromJson(Map<String, dynamic> json) {
    attendId = json['attend_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attend_id'] = this.attendId;
    return data;
  }
}
