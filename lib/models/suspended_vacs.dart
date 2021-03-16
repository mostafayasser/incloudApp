class RequestStatus {
  String status;
  String message;
  Data data;

  RequestStatus({this.status, this.message, this.data});

  RequestStatus.fromJson(Map<String, dynamic> json) {
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
  int vacId;
  int staus;

  Data({this.vacId, this.staus});

  Data.fromJson(Map<String, dynamic> json) {
    vacId = json['vac_id'];
    staus = json['staus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vac_id'] = this.vacId;
    data['staus'] = this.staus;
    return data;
  }
}
