class ServerTime {
  int time;

  ServerTime.fromJson(Map<String, dynamic> json) {
    time = (json['server_time'] != null || json['server_time'] != "")
        ? json['server_time']
        : "00:00:00";
  }
}
