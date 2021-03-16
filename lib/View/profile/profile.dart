import 'dart:convert';
import 'dart:typed_data';

import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/profile_data.dart';
import 'package:attendanceapp/models/profile_data_parameters.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePage extends StatefulWidget {
  String lang;
  String photo;
  ProfilePage(this.lang, this.photo);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileData data;
  APIService service = APIService();
  bool load = false;
  @override
  void initState() {
    getDate();
    super.initState();
  }

  void getDate() async {
    if (mounted) {
      setState(() {
        load = true;
      });

      var par = Profile_Parameters(
          compId: UserDataShared.comid,
          empId: UserDataShared.emid,
          fcmToken: UserDataShared.token,
          lang: widget.lang);

      var res = await service.getUserData(par);

      if (!res.error) {
        data = res.data;
      } else {
        data = null;
      }
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64.decode(widget.photo);
    return (load || data == null)
        ? Center(
            child: Container(
            child: SpinKitThreeBounce(
              color: Color(0xff35BCB7),
              size: 30,
            ),
          ))
        : ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: MemoryImage(bytes),
                  radius: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "name".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.empData.empName ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "emp_id".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.empData.nationalId ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "Branch".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.branchData.branchName ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "Title".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.empData.title ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "mobile".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.empData.mobileNo ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "Email".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.empData.mail ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    "department".tr() + ":",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    data.data.depData.depName ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }
}
