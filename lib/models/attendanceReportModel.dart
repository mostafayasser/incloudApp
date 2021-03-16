class AttendanceRecord {
  String date, checkInDate, checkOutDate, workHours, overtime;
  AttendanceRecord.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    checkInDate = json['checkin_date'] ?? "";
    checkOutDate = json['checkout_date'] ?? "";
    workHours = json['work_hours'] ?? "";
    overtime = json['overtime'] ?? "";
  }
}

class AttendanceReport {
  List<AttendanceRecord> attendanceRecords;
  AttendanceReport.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      attendanceRecords = new List<AttendanceRecord>();
      print(json['data']);
      json["data"].values.forEach((record) {
        attendanceRecords.add(new AttendanceRecord.fromJson(record));
      });
    }
  }
}
