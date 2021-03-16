class HomeModels {
  String status;
  String message;
  Data data;

  HomeModels({this.status, this.message, this.data});

  HomeModels.fromJson(Map<String, dynamic> json) {
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
  EmpDataC empData;
  BranchData branchData;
  ShiftData shiftData;
  AttendanceStatus attendanceData;

  Data({this.empData, this.branchData, this.shiftData});

  Data.fromJson(Map<String, dynamic> json) {
    empData = json['emp_data'] != null
        ? new EmpDataC.fromJson(json['emp_data'])
        : null;
    branchData = json['branch_data'] != null
        ? new BranchData.fromJson(json['branch_data'])
        : null;
    shiftData = json['shift_data'] != null
        ? new ShiftData.fromJson(json['shift_data'])
        : null;
    attendanceData = json['attendance_status'] != null
        ? new AttendanceStatus.fromJson(json['attendance_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.empData != null) {
      data['emp_data'] = this.empData.toJson();
    }
    if (this.branchData != null) {
      data['branch_data'] = this.branchData.toJson();
    }
    if (this.shiftData != null) {
      data['shift_data'] = this.shiftData.toJson();
    }
    if (this.attendanceData != null) {
      data['attendance_status'] = this.attendanceData.toJson();
    }
    return data;
  }
}

class EmpDataC {
  String empName;
  String compName;
  String title;
  int empOutarea;
  String photo;

  EmpDataC(
      {this.empName, this.compName, this.title, this.empOutarea, this.photo});

  EmpDataC.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    compName = json['comp_name'];
    title = json['title'];
    empOutarea = json['emp_outarea'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['comp_name'] = this.compName;
    data['title'] = this.title;
    data['emp_outarea'] = this.empOutarea;
    data['photo'] = this.photo;
    return data;
  }
}

class BranchData {
  String long;
  String lat;
  int branchOutarea;

  BranchData({this.long, this.lat, this.branchOutarea});

  BranchData.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    lat = json['lat'];
    branchOutarea = json['branch_outarea'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['branch_outarea'] = this.branchOutarea;
    return data;
  }
}

class ShiftData {
  String shiftName;
  int allowOverTime;
  int includeTwoDays;
  int shift_id;
  Times times;
  ShiftDays shiftDays;

  ShiftData(
      {this.shiftName,
      this.allowOverTime,
      this.includeTwoDays,
      this.times,
      this.shift_id,
      this.shiftDays});

  ShiftData.fromJson(Map<String, dynamic> json) {
    shift_id = json["shift_id"];
    shiftName = json['shift_name'];
    allowOverTime = json['allow_over_time'];
    includeTwoDays = json['include_two_days'];
    times = json['times'] != null ? new Times.fromJson(json['times']) : null;
    shiftDays = json['shift_days'] != null
        ? new ShiftDays.fromJson(json['shift_days'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["shift_id"] = this.shift_id;
    data['shift_name'] = this.shiftName;
    data['allow_over_time'] = this.allowOverTime;
    data['include_two_days'] = this.includeTwoDays;
    if (this.times != null) {
      data['times'] = this.times.toJson();
    }
    if (this.shiftDays != null) {
      data['shift_days'] = this.shiftDays.toJson();
    }
    return data;
  }
}

class Times {
  String earlyCheckIn;
  String startCheckIn;
  String endCheckIn;
  String earlyCheckOut;
  String startCheckOut;
  String endCheckOut;

  Times(
      {this.earlyCheckIn,
      this.startCheckIn,
      this.endCheckIn,
      this.earlyCheckOut,
      this.startCheckOut,
      this.endCheckOut});

  Times.fromJson(Map<String, dynamic> json) {
    earlyCheckIn = json['early_check_in'].toString();
    startCheckIn = json['start_check_in'].toString();
    endCheckIn = json['end_check_in'].toString();
    earlyCheckOut = json['early_check_out'].toString();
    startCheckOut = json['start_check_out'].toString();
    endCheckOut = json['end_check_out'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['early_check_in'] = this.earlyCheckIn;
    data['start_check_in'] = this.startCheckIn;
    data['end_check_in'] = this.endCheckIn;
    data['early_check_out'] = this.earlyCheckOut;
    data['start_check_out'] = this.startCheckOut;
    data['end_check_out'] = this.endCheckOut;
    return data;
  }
}

class ShiftDays {
  int sat;
  int sun;
  int mon;
  int tue;
  int wed;
  int thu;
  int fri;

  ShiftDays(
      {this.sat, this.sun, this.mon, this.tue, this.wed, this.thu, this.fri});

  ShiftDays.fromJson(Map<String, dynamic> json) {
    sat = json['sat'];
    sun = json['sun'];
    mon = json['mon'];
    tue = json['tue'];
    wed = json['wed'];
    thu = json['thu'];
    fri = json['fri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sat'] = this.sat;
    data['sun'] = this.sun;
    data['mon'] = this.mon;
    data['tue'] = this.tue;
    data['wed'] = this.wed;
    data['thu'] = this.thu;
    data['fri'] = this.fri;
    return data;
  }
}

class AttendanceStatus {
  String atwork;
  int attendTime, transactionID;

  AttendanceStatus.fromJson(Map<String, dynamic> json) {
    atwork = json['atwork'];
    attendTime = json['attend_time'] == ""
        ? 0
        : json['attend_time'] ?? json['attend_time'];
    transactionID = json['attend_trans_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atwork'] = this.atwork;
    data['attend_time'] = this.attendTime;

    return data;
  }
}
