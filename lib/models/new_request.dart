class NewRequestModels {
  String status;
  String message;
  Data data;

  NewRequestModels({this.status, this.message, this.data});

  NewRequestModels.fromJson(Map<String, dynamic> json) {
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

  Data({this.vacId});

  Data.fromJson(Map<String, dynamic> json) {
    vacId = json['vac_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vac_id'] = this.vacId;
    return data;
  }
}
