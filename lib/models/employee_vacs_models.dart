class EmployeesVacsModels {
  String status;
  String message;
  Data data;

  EmployeesVacsModels({this.status, this.message, this.data});

  EmployeesVacsModels.fromJson(Map<String, dynamic> json) {
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
  List<VacsBalance> vacsBalance;
  List<LeavesBalance> leavesBalance;

  Data({this.vacsBalance, this.leavesBalance});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vacs_balance'] != null) {
      vacsBalance = new List<VacsBalance>();
      json['vacs_balance'].forEach((v) {
        vacsBalance.add(new VacsBalance.fromJson(v));
      });
    }
    if (json['leaves_balance'] != null) {
      leavesBalance = new List<LeavesBalance>();
      json['leaves_balance'].forEach((v) {
        leavesBalance.add(new LeavesBalance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vacsBalance != null) {
      data['vacs_balance'] = this.vacsBalance.map((v) => v.toJson()).toList();
    }
    if (this.leavesBalance != null) {
      data['leaves_balance'] =
          this.leavesBalance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VacsBalance {
  int regular;
  int irregular;
  int sick;
  int advance;

  VacsBalance({this.regular, this.irregular, this.sick, this.advance});

  VacsBalance.fromJson(Map<String, dynamic> json) {
    regular = json['regular'];
    irregular = json['irregular'];
    sick = json['sick'];
    advance = json['advance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regular'] = this.regular;
    data['irregular'] = this.irregular;
    data['sick'] = this.sick;
    data['advance'] = this.advance;
    return data;
  }
}

class LeavesBalance {
  int month;
  int leaves;

  LeavesBalance({this.month, this.leaves});

  LeavesBalance.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    leaves = json['leaves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['leaves'] = this.leaves;
    return data;
  }
}
