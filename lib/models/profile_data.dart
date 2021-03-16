class ProfileData {
  String status;
  String message;
  Data data;

  ProfileData({this.status, this.message, this.data});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
  EmpData empData;
  BranchData branchData;
  DepData depData;
  ShiftData shiftData;

  Data({this.empData, this.branchData, this.depData, this.shiftData});

  Data.fromJson(Map<String, dynamic> json) {
    empData = json['emp_data'] != null
        ? new EmpData.fromJson(json['emp_data'])
        : null;
    branchData = json['branch_data'] != null
        ? new BranchData.fromJson(json['branch_data'])
        : null;
    depData = json['dep_data'] != null
        ? new DepData.fromJson(json['dep_data'])
        : null;
    shiftData = json['shift_data'] != null
        ? new ShiftData.fromJson(json['shift_data'])
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
    if (this.depData != null) {
      data['dep_data'] = this.depData.toJson();
    }
    if (this.shiftData != null) {
      data['shift_data'] = this.shiftData.toJson();
    }
    return data;
  }
}

class EmpData {
  String empName;
  String compName;
  String title;
  String mobileNo;
  String mail;
  String birthDate;
  String gender;
  String address;
  String nationalId;

  EmpData(
      {this.empName,
      this.compName,
      this.title,
      this.mobileNo,
      this.mail,
      this.birthDate,
      this.gender,
      this.address,
      this.nationalId});

  EmpData.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    compName = json['comp_name'];
    title = json['title'];
    mobileNo = json['mobile_no'];
    mail = json['mail'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    address = json['address'];
    nationalId = json['national_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['comp_name'] = this.compName;
    data['title'] = this.title;
    data['mobile_no'] = this.mobileNo;
    data['mail'] = this.mail;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['national_id'] = this.nationalId;
    return data;
  }
}

class BranchData {
  int branchId;
  String branchName;

  BranchData({this.branchId, this.branchName});

  BranchData.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    return data;
  }
}

class DepData {
  int depId;
  String depName;

  DepData({this.depId, this.depName});

  DepData.fromJson(Map<String, dynamic> json) {
    depId = json['dep_id'];
    depName = json['dep_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dep_id'] = this.depId;
    data['dep_name'] = this.depName;
    return data;
  }
}

class ShiftData {
  int shiftId;
  String shiftName;
  int allowOverTime;
  int includeTwoDays;
  Times times;
  ShiftDays shiftDays;

  ShiftData(
      {this.shiftId,
      this.shiftName,
      this.allowOverTime,
      this.includeTwoDays,
      this.times,
      this.shiftDays});

  ShiftData.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
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
    data['shift_id'] = this.shiftId;
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
  int earlyCheckIn;
  String startCheckIn;
  String endCheckIn;
  int earlyCheckOut;
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
    earlyCheckIn = json['early_check_in'];
    startCheckIn = json['start_check_in'];
    endCheckIn = json['end_check_in'];
    earlyCheckOut = json['early_check_out'];
    startCheckOut = json['start_check_out'];
    endCheckOut = json['end_check_out'];
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
