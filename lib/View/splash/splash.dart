import 'dart:async';
import 'package:attendanceapp/View/Credential/Signin/signin.dart';
import 'package:attendanceapp/View/main_page/main_page.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/home_prameters_models.dart';
import 'package:attendanceapp/models/userSignedParameter.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  APIService service = APIService();
  SharedPreferences sharedPreferences;
  bool isLogedIn = false;
  bool isLoad = false;
  int isHome = 0;
  Timer _timer;
  String email = "";
  String password = "";
  HomeModels homeModels;

  checkLogedIn() async {
    if (mounted) {
      setState(() {
        isLoad = true;
      });
      sharedPreferences = await SharedPreferences.getInstance();
      isLogedIn = sharedPreferences.getBool("logedin") ?? false;
      if (!isLogedIn) {
        _timer = Timer(Duration(seconds: 2), () {
          setState(() {
            isHome = 1;
            isLoad = false;
            _timer.cancel();
          });
        });
      } else {
        email = sharedPreferences.getString("email");
        password = sharedPreferences.getString("password");
        var connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          setState(() {
            isLoad = true;
          });

          String appId = await PlatformDeviceId.getDeviceId;
          var userPar = UserSignedParameters(
              email: email,
              password: password,
              deviceId: appId,
              lang: (context.locale == Locale("ar")) ? "ar" : "en");

          var res = await service.login(userPar).catchError((e) {
            setState(() {
              isHome = 1;
            });
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

            UserDataShared.emid = res.data.data.empId;
            UserDataShared.comid = res.data.data.compId;

            UserDataShared.token = res.data.data.fcmToken;
            var home_parameters = HomeParameters(
                compId: UserDataShared.comid,
                empId: UserDataShared.emid,
                fcmToken: UserDataShared.token,
                lang: (context.locale == Locale('ar')) ? "ar" : "en");

            var home_res =
                await service.homeData(home_parameters).catchError((e) {
              setState(() {
                isHome = 1;
              });
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });

            if (!home_res.error) {
              UserDataShared.shiftID = home_res.data.data.shiftData.shift_id;
              homeModels = home_res.data;
              setState(() {
                isHome = 2;
              });
            } else {
              setState(() {
                isHome = 1;
              });
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
            setState(() {
              isHome = 1;
            });
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
        } else {
          setState(() {
            isHome = 1;
          });
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
      }
    }
  }

  @override
  void initState() {
    checkLogedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (isHome == 0)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      "assets/images/logoSplashScreen.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Center(
                  child: SpinKitCircle(
                    color: Color(0xff35BCB7),
                  ),
                ),
              ],
            )
          : (isHome == 2)
              ? MainPage(homeModels)
              : Signin(),
    );
  }
}
