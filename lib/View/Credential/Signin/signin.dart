import 'package:attendanceapp/View/Password_changed/password_changed.dart';
import 'package:attendanceapp/View/main_page/main_page.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/home_prameters_models.dart';
import 'package:attendanceapp/models/userSignedParameter.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final APIService service = APIService();

  bool passwordHide = true;
  SharedPreferences sharedPreferences;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoad = false;
  @override
  void initState() {
    initializeLocalStorage();
    checkConnectivity();
    checkLocationPermission();
    super.initState();
  }

  void initializeLocalStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool mobileConnection = connectivityResult == ConnectivityResult.mobile;
    bool wifiConnection = connectivityResult == ConnectivityResult.wifi;
    if (!mobileConnection && !wifiConnection) {
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

  Future<void> checkLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff384862),
      body: ModalProgressHUD(
        inAsyncCall: isLoad,
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 100, bottom: 20),
                      height: 140,
                      width: 140,
                      child: Image.asset(
                        "assets/images/IHRLogo.png",
                        fit: BoxFit.cover,
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _email,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Email".tr(),
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "mainFont",
                        fontSize: 18),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  controller: _password,
                  obscureText: passwordHide,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Password".tr(),
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "mainFont",
                        fontSize: 18),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                    ),
                    suffixIcon: (passwordHide)
                        ? IconButton(
                            icon: Icon(
                              Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordHide = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordHide = true;
                              });
                            },
                          ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: FlatButton(
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());

                    if (connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi) {
                      setState(() {
                        isLoad = true;
                      });

                      String appId = await PlatformDeviceId.getDeviceId;
                      var userPar = UserSignedParameters(
                          email: _email.text,
                          password: _password.text,
                          deviceId: appId,
                          lang: (context.locale == Locale("ar")) ? "ar" : "en");

                      var res = await service.login(userPar).catchError((e) {
                        Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });

                      if (!res.error) {
                        sharedPreferences.setBool("logedin", true);
                        sharedPreferences.setString("email", _email.text);
                        sharedPreferences.setString("password", _password.text);
                        UserDataShared.emid = res.data.data.empId;
                        UserDataShared.comid = res.data.data.compId;

                        UserDataShared.token = res.data.data.fcmToken;
                        var home_parameters = HomeParameters(
                            compId: UserDataShared.comid,
                            empId: UserDataShared.emid,
                            fcmToken: UserDataShared.token,
                            lang:
                                (context.locale == Locale('ar')) ? "ar" : "en");

                        var home_res = await service
                            .homeData(home_parameters)
                            .catchError((e) {
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                        FocusScope.of(context).unfocus();
                        if (!home_res.error) {
                          UserDataShared.shiftID =
                              home_res.data.data.shiftData.shift_id;

                          if (res.data.data.first_login) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PasswordChanged(home_res.data)));
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage(home_res.data)),
                                (Route<dynamic> route) => false);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: (home_res.data.message == null)
                                  ? (home_res.errorMessage)
                                  : home_res.data.message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      } else {
                        sharedPreferences.setBool("logedin", false);
                        Fluttertoast.showToast(
                            msg: (res.data.message == null)
                                ? (res.errorMessage)
                                : res.data.message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      setState(() {
                        isLoad = false;
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
                    setState(() {
                      isLoad = false;
                    });
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
                        "LOG IN".tr(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
