import 'dart:convert';
import 'dart:typed_data';

import 'package:attendanceapp/View/Credential/Signin/signin.dart';
import 'package:attendanceapp/View/EmployeeVacs/employee_vacs.dart';
import 'package:attendanceapp/View/Home/Home.dart';
import 'package:attendanceapp/View/New_Request/new_request.dart';
import 'package:attendanceapp/View/Reports/reports.dart';
import 'package:attendanceapp/View/Request_status/Request_status.dart';
import 'package:attendanceapp/View/my_Request/my_request.dart';
import 'package:attendanceapp/View/official_vacs/official_vacs.dart';
import 'package:attendanceapp/View/profile/profile.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/home_prameters_models.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  HomeModels homeModels;
  MainPage(this.homeModels);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          (page == 0)
              ? "Home".tr()
              : (page == 1)
                  ? "notifications".tr()
                  : (page == 2)
                      ? "vacsBalance".tr()
                      : (page == 3)
                          ? "myRequest".tr()
                          : (page == 4)
                              ? "NewRequest".tr()
                              : (page == 5)
                                  ? "Reports".tr()
                                  : (page == 6)
                                      ? "Profile".tr()
                                      : "",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                Color(0xff35BCB7),
                Color(0xff06B5CF),
              ],
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(this),
      body: (widget.homeModels == null)
          ? Container()
          : (page == 0)
              ? Home(widget.homeModels)
              : (page == 1)
                  ? OfficialVacss(
                      (context.locale == Locale("ar") ? "ar" : "en"))
                  : (page == 2)
                      ? EmployeeVacs(
                          (context.locale == Locale("ar") ? "ar" : "en"))
                      : (page == 3)
                          ? MyRequestPage(
                              (context.locale == Locale("ar") ? "ar" : "en"))
                          : (page == 4)
                              ? NewRequestPage(widget.homeModels)
                              : (page == 5)
                                  ? ReportsPage()
                                  : ProfilePage(
                                      (context.locale == Locale("ar")
                                          ? "ar"
                                          : "en"),
                                      widget.homeModels.data.empData.photo),
    );
  }
}

class AppDrawer extends StatefulWidget {
  _MainPageState mainPageState;
  AppDrawer(this.mainPageState);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  APIService service = APIService();
  HomeModels homeModels;

  bool loading = false, languageChange = false;
  @override
  void didChangeDependencies() {
    setState(() {
      loading = true;
    });
    var home_parameters = HomeParameters(
        compId: UserDataShared.comid,
        empId: UserDataShared.emid,
        fcmToken: UserDataShared.token,
        lang: (context.locale == Locale('ar')) ? "ar" : "en");
    service.homeData(home_parameters).then((value) {
      homeModels = value.data;
      setState(() {
        loading = false;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool en = context.locale == Locale("en");
    Uint8List bytes = loading
        ? new Uint8List(10)
        : base64.decode(homeModels.data.empData.photo);
    String empName = loading ? "" : homeModels.data.empData.empName,
        title = loading ? "" : homeModels.data.empData.title;
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.75,
            color: Colors.white,
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("EN"),
                        Switch(
                          value: en,
                          onChanged: (value) {
                            if (value) {
                              setState(() {
                                context.locale = Locale("en");
                              });
                            } else {
                              setState(() {
                                context.locale = Locale("ar");
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 0;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.home,
                            color: Color(0xff35BCB7),
                          ),
                          text: "Home".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 6;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.person,
                            color: Color(0xff35BCB7),
                          ),
                          text: "Profile".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 1;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff35BCB7),
                          ),
                          text: "notifications".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 2;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff35BCB7),
                          ),
                          text: "vacsBalance".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 3;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.list,
                            color: Color(0xff35BCB7),
                          ),
                          text: "myRequest".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 4;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.add_box,
                            color: Color(0xff35BCB7),
                          ),
                          text: "NewRequest".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.mainPageState.setState(() {
                          widget.mainPageState.page = 5;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.report,
                            color: Color(0xff35BCB7),
                          ),
                          text: "Reports".tr(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () async {
                        var shared = await SharedPreferences.getInstance();
                        var checkedIn = shared.getBool('check');
                        shared.clear();
                        shared.setBool('check', checkedIn);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Signin()),
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        child: ListBtn(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Color(0xff35BCB7),
                          ),
                          text: "logOut".tr(),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff35BCB7),
                        Color(0xff06B5CF),
                      ],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(bytes),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (empName.length > 18)
                                  ? empName.substring(0, 15)
                                  : empName,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (title.length > 15)
                                  ? title.substring(0, 15)
                                  : title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "mainFont",
                              ),
                            ),
                            /* SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.homeModels.data.empData.compName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: "mainFont",
                        ),
                      ), */
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class ListBtn extends StatelessWidget {
  final Icon icon;
  final String text;

  ListBtn({this.icon, this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              icon,
              Expanded(child: Container()),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
