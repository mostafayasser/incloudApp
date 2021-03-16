class OfficialResponse {
  String status;
  String message;
  Data data;

  OfficialResponse({this.status, this.message, this.data});

  OfficialResponse.fromJson(Map<String, dynamic> json) {
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
  List<OfficialVacs> officialVacs;

  Data({this.officialVacs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['official_vacs'] != null) {
      officialVacs = new List<OfficialVacs>();
      json['official_vacs'].forEach((v) {
        officialVacs.add(new OfficialVacs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.officialVacs != null) {
      data['official_vacs'] = this.officialVacs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfficialVacs {
  String vacDate;
  int vacStatus;
  String vacComment;

  OfficialVacs({this.vacDate, this.vacStatus, this.vacComment});

  OfficialVacs.fromJson(Map<String, dynamic> json) {
    vacDate = json['vac_date'];
    vacStatus = json['vac_status'];
    vacComment = json['vac_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vac_date'] = this.vacDate;
    data['vac_status'] = this.vacStatus;
    data['vac_comment'] = this.vacComment;
    return data;
  }
}
