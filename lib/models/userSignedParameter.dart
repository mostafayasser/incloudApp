class UserSignedParameters {
  String email;
  String password;
  String deviceId;
  String curNo2;
  String lang;

  UserSignedParameters(
      {this.email, this.password, this.deviceId, this.lang});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_id'] = this.deviceId;
    data['lang'] = this.lang;
    return data;
  }
}