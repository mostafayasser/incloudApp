import 'package:attendanceapp/View/main_page/main_page.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/change_parameters.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordChanged extends StatefulWidget {
  final HomeModels homeModels;
  PasswordChanged(this.homeModels);
  @override
  _PasswordChangedState createState() => _PasswordChangedState();
}

class _PasswordChangedState extends State<PasswordChanged> {
  bool load = false;
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  APIService service = APIService();

  @override
  void initState() {
    initLocalStorage();
    super.initState();
  }

  void initLocalStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "changePassword".tr(),
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
      body: Form(
        key: _formKey,
        child: ModalProgressHUD(
          inAsyncCall: load,
          child: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: _oldPassword,
                    validator: (val) =>
                        val.isEmpty ? 'EnterOldpassword'.tr() : null,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "mainFont",
                        fontSize: 18),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "oldPassword".tr(),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "mainFont",
                          fontSize: 18),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: _newPassword,
                    validator: (val) => val.isEmpty ? 'EnterNew'.tr() : null,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "mainFont",
                        fontSize: 18),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "NewPassword".tr(),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "mainFont",
                          fontSize: 18),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: _confirmPassword,
                    validator: (val) {
                      if (val != _newPassword.text) {
                        return "dosntmatch".tr();
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "mainFont",
                        fontSize: 18),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm".tr(),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "mainFont",
                          fontSize: 18),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());

                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        setState(() {
                          load = true;
                        });
                        var par = ChangesParameters(
                          compId: UserDataShared.comid,
                          empId: UserDataShared.emid,
                          fcmToken: UserDataShared.token,
                          firstLogin: false,
                          lang: context.locale == Locale("ar") ? "ar" : "en",
                          newPass: _newPassword.text,
                          oldPass: _oldPassword.text,
                        );

                        var res = await service.requestChangePassword(par);

                        if (!res.error) {
                          sharedPreferences.setString(
                              "password", _newPassword.text);
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainPage(widget.homeModels)),
                              (Route<dynamic> route) => false);
                        } else {
                          Fluttertoast.showToast(
                              msg: (res.data.message == null)
                                  ? res.errorMessage
                                  : res.data.message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }

                        setState(() {
                          load = false;
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: 'checkConnection'.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff35BCB7),
                          Color(0xff06B5CF),
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "con".tr().toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
