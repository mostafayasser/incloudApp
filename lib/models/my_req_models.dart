class MyRequestModels {
  String status;
  String message;
  Data data;

  MyRequestModels({this.status, this.message, this.data});

  MyRequestModels.fromJson(Map<String, dynamic> json) {
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
  List<Vacs> vacs;
  List<Leaves> leaves;
  List<UpnormalRequests> upnormalRequests;

  Data({this.vacs, this.leaves, this.upnormalRequests});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vacs'] != null) {
      vacs = new List<Vacs>();
      json['vacs'].forEach((v) {
        vacs.add(new Vacs.fromJson(v));
      });
    }
    if (json['leaves'] != null) {
      leaves = new List<Leaves>();
      json['leaves'].forEach((v) {
        leaves.add(new Leaves.fromJson(v));
      });
    }
    if (json['upnormal_requests'] != null) {
      upnormalRequests = new List<UpnormalRequests>();
      json['upnormal_requests'].forEach((v) {
        upnormalRequests.add(new UpnormalRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vacs != null) {
      data['vacs'] = this.vacs.map((v) => v.toJson()).toList();
    }
    if (this.leaves != null) {
      data['leaves'] = this.leaves.map((v) => v.toJson()).toList();
    }
    if (this.upnormalRequests != null) {
      data['upnormal_requests'] =
          this.upnormalRequests.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vacs {
  int vacId;
  String vacType;
  String startDate;
  String endDate;
  int noOfDays;
  String createdBy;
  String reason;
  int status;
  String createdDate;

  Vacs(
      {this.vacId,
      this.vacType,
      this.startDate,
      this.endDate,
      this.noOfDays,
      this.createdBy,
      this.reason,
      this.status,
      this.createdDate});

  Vacs.fromJson(Map<String, dynamic> json) {
    vacId = json['vac_id'];
    vacType = json['vac_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    noOfDays = json['no_of_days'];
    createdBy = json['created_by'];
    reason = json['reason'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vac_id'] = this.vacId;
    data['vac_type'] = this.vacType;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['no_of_days'] = this.noOfDays;
    data['created_by'] = this.createdBy;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class Leaves {
  int leaveId;
  String leaveDate;
  String leaveTime;
  String missedTime;
  String createdBy;
  String leaveReason;
  int confirmed;
  String createdDate;

  Leaves(
      {this.leaveId,
      this.leaveDate,
      this.leaveTime,
      this.missedTime,
      this.createdBy,
      this.leaveReason,
      this.confirmed,
      this.createdDate});

  Leaves.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    leaveDate = json['leave_date'];
    leaveTime = json['leave_time'];
    missedTime = json['missed_time'];
    createdBy = json['created_by'];
    leaveReason = json['leave_reason'];
    confirmed = json['confirmed'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this.leaveId;
    data['leave_date'] = this.leaveDate;
    data['leave_time'] = this.leaveTime;
    data['missed_time'] = this.missedTime;
    data['created_by'] = this.createdBy;
    data['leave_reason'] = this.leaveReason;
    data['confirmed'] = this.confirmed;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class UpnormalRequests {
  int upnormalId;
  int compId;
  int empId;
  String upnormalTime;
  String upnormalType;
  double upnormalLong;
  double upnormalLat;
  double away;
  int status;

  UpnormalRequests(
      {this.upnormalId,
      this.compId,
      this.empId,
      this.upnormalTime,
      this.upnormalType,
      this.upnormalLong,
      this.upnormalLat,
      this.away,
      this.status});

  UpnormalRequests.fromJson(Map<String, dynamic> json) {
    upnormalId = json['upnormal_id'];
    compId = json['comp_id'];
    empId = json['emp_id'];
    upnormalTime = json['upnormal_time'];
    upnormalType = json['upnormal_type'];
    upnormalLong = double.parse(json['upnormal_long'].toString());
    upnormalLat = double.parse(json['upnormal_lat'].toString());
    away = double.parse(json['away'].toString());
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upnormal_id'] = this.upnormalId;
    data['comp_id'] = this.compId;
    data['emp_id'] = this.empId;
    data['upnormal_time'] = this.upnormalTime;
    data['upnormal_type'] = this.upnormalType;
    data['upnormal_long'] = this.upnormalLong;
    data['upnormal_lat'] = this.upnormalLat;
    data['away'] = this.away;
    data['status'] = this.status;
    return data;
  }
}
