class UpnormalModels {
  String status;
  String message;
  Data data;

  UpnormalModels({this.status, this.message, this.data});

  UpnormalModels.fromJson(Map<String, dynamic> json) {
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
  int upnormalId;

  Data({this.upnormalId});

  Data.fromJson(Map<String, dynamic> json) {
    upnormalId = json['upnormal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upnormal_id'] = this.upnormalId;
    return data;
  }
}
