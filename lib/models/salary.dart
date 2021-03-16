import 'dart:convert';

class Salaries {
  String status;
  String message;
  Data data;

  Salaries({this.status, this.message, this.data});

  Salaries.fromJson(Map<String, dynamic> json) {
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
  Earning earning;
  Deductions deductions;
  int netSalary;

  Data({this.earning, this.deductions, this.netSalary});

  Data.fromJson(Map<String, dynamic> json) {
    earning =
        json['earning'] != null ? new Earning.fromJson(json['earning']) : null;
    deductions = json['deductions'] != null
        ? new Deductions.fromJson(json['deductions'])
        : null;
    netSalary = json['net_salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.earning != null) {
      data['earning'] = this.earning.toJson();
    }
    if (this.deductions != null) {
      data['deductions'] = this.deductions.toJson();
    }
    data['net_salary'] = this.netSalary;
    return data;
  }
}

class Earning {
  List<Details> details;
  TotalEarning totalEarning;

  Earning({this.details, this.totalEarning});

  Earning.fromJson(List<dynamic> json) {
    if (json != null) {
      details = new List<Details>();
      json[0].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    totalEarning = json[1]['total_earning'] != null
        ? new TotalEarning.fromJson(json[1])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.totalEarning != null) {
      data['total_earning'] = this.totalEarning.toJson();
    }
    return data;
  }
}

class Details {
  String reason;
  int amount;

  Details({this.reason, this.amount});

  Details.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['amount'] = this.amount;
    return data;
  }
}

class TotalEarning {
  int amount;

  TotalEarning({this.amount});

  TotalEarning.fromJson(Map<String, dynamic> json) {
    amount = json.values.first;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    return data;
  }
}

class Deductions {
  List<Details> details;
  TotalEarning totalDeduction;

  Deductions({this.details, this.totalDeduction});

  Deductions.fromJson(List<dynamic> json) {
    if (json != null) {
      details = new List<Details>();
      json[0].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    totalDeduction = json[1]['total_deduction'] != null
        ? new TotalEarning.fromJson(json[1])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.totalDeduction != null) {
      data['total_deduction'] = this.totalDeduction.toJson();
    }
    return data;
  }
}
