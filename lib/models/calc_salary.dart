class CalculateSalaries {
  String status;
  String message;
  Data data;

  CalculateSalaries({this.status, this.message, this.data});

  CalculateSalaries.fromJson(Map<String, dynamic> json) {
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
  List<CalcSalaries> calcSalaries;

  Data({this.calcSalaries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['calc_salaries'] != null) {
      calcSalaries = new List<CalcSalaries>();
      print(json['calc_salaries']);
      json['calc_salaries'].forEach((v) {
        calcSalaries.add(new CalcSalaries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calcSalaries != null) {
      data['calc_salaries'] = this.calcSalaries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalcSalaries {
  int year;
  int month;

  CalcSalaries({this.year, this.month});

  CalcSalaries.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    return data;
  }
}
