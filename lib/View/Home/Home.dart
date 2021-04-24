import 'package:attendanceapp/models/Check_Out_Parameters.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/check_in_Parameters.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/home_prameters_models.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Home extends StatefulWidget {
  final HomeModels homeModels;
  Home(this.homeModels);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  APIService service = APIService();
  Location location = new Location();
  SharedPreferences sharedPreferences;
  LocationData locationData;
  LocationData loc;
  bool isCheckIn = true;
  bool load = false;
  String distance = "";
  int attend_id = 0;
  String displayTime = "";
  DateFormat format = DateFormat("EEEE, MMMM dd, yyyy");
  StopWatchTimer _stopWatchTimer;
  int val = 0;
  static int firstTime = 0;
  @override
  void initState() {
    if (mounted) {
      location.onLocationChanged.listen((event) {
        setState(() {
          loc = event;
        });
        calculateDistance(event);
      });
      getHomeData();
      checkLocationPermission();
    }
    super.initState();
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

  Future<void> getHomeData() async {
    setState(() {
      load = true;
    });

    sharedPreferences = await SharedPreferences.getInstance();
    if (firstTime == 0) {
      isCheckIn =
          widget.homeModels.data.attendanceData.atwork.toLowerCase() == "no";
      firstTime = 1;
    }

    attend_id = sharedPreferences.getInt("attend") ?? 0;
    val = sharedPreferences.getInt("time") ?? 0;
    var serverTime = await service.getServerTime();

    var attendTime = widget.homeModels.data.attendanceData.attendTime * 1000;
    var timerDifference = (serverTime.data.time * 1000) - attendTime;

    print("attend: $attendTime");
    print(timerDifference);
    print(isCheckIn);
    if (!isCheckIn) {
      _stopWatchTimer = StopWatchTimer();
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      _stopWatchTimer.setPresetTime(mSec: 0);
      _stopWatchTimer.setPresetTime(
          mSec: attendTime == 0 ? 0 : timerDifference);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      _stopWatchTimer.rawTime.listen((event) {
        setState(() {
          displayTime = StopWatchTimer.getDisplayTime(
              event >= 86400000 ? 0 : event,
              milliSecond: false);
        });
      });
    } else {
      _stopWatchTimer = StopWatchTimer();
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      setState(() {
        displayTime = StopWatchTimer.getDisplayTime(0, milliSecond: false);
      });
    }
    setState(() {
      load = false;
    });
  }

  void calculateDistance(LocationData data) {
    double distanceBetween = Geolocator.distanceBetween(
        data.latitude,
        data.longitude,
        double.parse(widget.homeModels.data.branchData.lat),
        double.parse(widget.homeModels.data.branchData.long));

    setState(() {
      distance = distanceBetween.toString();
    });
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: load,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            (!isCheckIn)
                ? Container(
                    child: Text(
                      displayTime,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(
                    child: Text(
                    "00:00:00",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  )),
            SizedBox(
              height: 50,
            ),
            Text(
              (isCheckIn) ? "pleaseCheckin".tr() : "pleaseCheckou".tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              (isCheckIn) ? "toStartWork".tr() : "workinHours".tr(),
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff35BCB7),
              size: 40,
            ),
            (!isCheckIn)
                ? SizedBox(
                    height: 10,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: FlatButton(
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());

                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    setState(() {
                      load = true;
                    });
                    locationData = await location.getLocation();

                    double distanceBetween = Geolocator.distanceBetween(
                        locationData.latitude,
                        locationData.longitude,
                        double.parse(widget.homeModels.data.branchData.lat),
                        double.parse(widget.homeModels.data.branchData.long));

                    if (widget.homeModels.data.empData.empOutarea != 0 ||
                        distanceBetween.toInt() <=
                            widget.homeModels.data.branchData.branchOutarea) {
                      if (checkDayShift(
                          "${DateFormat("EEEE").format(DateTime.now())}",
                          widget.homeModels.data.shiftData.shiftDays)) {
                        if (isCheckIn) {
                          setState(() {
                            load = true;
                          });
                          var par = CheckInParmeters(
                            compId: UserDataShared.comid,
                            empId: UserDataShared.emid,
                            fcmToken: UserDataShared.token,
                            shiftId: UserDataShared.shiftID,
                            lang:
                                (context.locale == Locale("ar") ? "ar" : "en"),
                            transLat: locationData.latitude,
                            transLong: locationData.longitude,
                            transType: "checkin",
                          );

                          var res = await service.requestCheckin(par);

                          /* setState(() {
                            load = false;
                          }); */
                          if (!res.error) {
                            setState(() {
                              isCheckIn = false;
                              attend_id = res.data.data.attendId;
                            });
                            sharedPreferences.setInt(
                                "time", DateTime.now().millisecondsSinceEpoch);
                            sharedPreferences.setBool('check', false);
                            sharedPreferences.setInt(
                                "attend", res.data.data.attendId);
                            var home_parameters = HomeParameters(
                                compId: UserDataShared.comid,
                                empId: UserDataShared.emid,
                                fcmToken: UserDataShared.token,
                                lang: (context.locale == Locale('ar'))
                                    ? "ar"
                                    : "en");

                            var home_res =
                                await service.homeData(home_parameters);
                            if (!home_res.error) {
                              widget.homeModels.data.attendanceData.attendTime =
                                  home_res.data.data.attendanceData.attendTime;

                              widget.homeModels.data.attendanceData
                                      .transactionID =
                                  home_res
                                      .data.data.attendanceData.transactionID;

                              print(
                                  "attend1: ${widget.homeModels.data.attendanceData.attendTime}");
                              print(
                                  "attend2: ${home_res.data.data.attendanceData.attendTime}");
                            }

                            await getHomeData();
                          } else {
                            Fluttertoast.showToast(
                                msg: (res.errorMessage == null ||
                                        res.errorMessage == "")
                                    ? res.data.message
                                    : res.errorMessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          setState(() {
                            load = true;
                          });

                          var par = CheckOutParameters(
                            compId: UserDataShared.comid,
                            empId: UserDataShared.emid,
                            fcmToken: UserDataShared.token,
                            shiftId: UserDataShared.shiftID,
                            lang:
                                (context.locale == Locale("ar") ? "ar" : "en"),
                            transLat: locationData.latitude,
                            transLong: locationData.longitude,
                            transType: "checkout",
                            attendTransId: widget
                                .homeModels.data.attendanceData.transactionID,
                            overtime: displayTime,
                            totalHours: displayTime,
                            workHours: displayTime,
                          );

                          var res = await service.requestCheckOut(par);
                          setState(() {
                            load = false;
                          });
                          print(widget
                              .homeModels.data.attendanceData.transactionID);
                          //sharedPreferences.setBool('check', true);
                          if (!res.error) {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);

                            _stopWatchTimer.setPresetTime(mSec: 0);
                            _stopWatchTimer.dispose();
                            displayTime = "00:00:00";

                            sharedPreferences.setInt("time", 0);
                            sharedPreferences.setBool('check', true);
                            setState(() {
                              isCheckIn = true;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: (res.errorMessage == null ||
                                        res.errorMessage == "")
                                    ? res.data.message
                                    : res.errorMessage,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'requestNotPermirred'.tr(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'outOfArea'.tr(),
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
                },
                child: Center(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            (isCheckIn) ? "Checkin".tr() : "checkOut".tr(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          (isCheckIn) ? Icons.location_on : Icons.exit_to_app,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              format.format(DateTime.now()),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
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
                      child: Text(
                        "away".tr(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${distance.split(".")[0]}" + "m".tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
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
                      child: Text(
                        "max".tr(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.homeModels.data.branchData.branchOutarea}" +
                          "m".tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
            /* Text(
              "away".tr() + " ${distance.split(".")[0]}" + "m".tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "max".tr() +
                  " ${widget.homeModels.data.branchData.branchOutarea}" +
                  "m".tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ), */
            SizedBox(
              height: 10,
            ),
            /* Text(
              loc == null ? "" : "(${loc.latitude}, ${loc.longitude})",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "(${double.parse(widget.homeModels.data.branchData.lat)}, ${double.parse(widget.homeModels.data.branchData.long)})",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ), */
          ],
        ),
      ),
    );
  }

  bool checkDayShift(String day, ShiftDays shiftDays) {
    if (day == "Saturday") {
      if (shiftDays.sat == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Sunday") {
      if (shiftDays.sun == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Monday") {
      if (shiftDays.mon == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Tuesday") {
      if (shiftDays.tue == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Wednesday") {
      if (shiftDays.wed == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Thursday") {
      if (shiftDays.thu == 0) {
        return false;
      } else {
        return true;
      }
    } else if (day == "Friday") {
      if (shiftDays.fri == 0) {
        return false;
      } else {
        return true;
      }
    }

    return false;
  }
}
