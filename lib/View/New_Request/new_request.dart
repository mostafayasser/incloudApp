import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/Request_parameters.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/leave_parameters.dart';
import 'package:attendanceapp/models/upnormal_para.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class NewRequestPage extends StatefulWidget {
  final HomeModels homeModels;
  NewRequestPage(this.homeModels);
  @override
  _NewRequestPageState createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  APIService service = APIService();
  final _formKey = GlobalKey<FormState>();
  Location location = new Location();
  TextEditingController requestType = TextEditingController();
  TextEditingController vacsTyp = TextEditingController();
  TextEditingController reason = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int no_days = 1;
  String leaveTime = "14";
  bool load = false;
  String reqType = "vacation".tr();
  String vacType = "regular".tr();
  TimeOfDay selectedTime = TimeOfDay.now();
  var format = DateFormat("HH:mm");
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != selectedTime)
      setState(() {
        selectedTime = pickedTime;
      });
  }

  @override
  Widget build(BuildContext context) {
    /*  var missedTime = int.parse(widget
            .homeModels.data.shiftData.times.startCheckOut
            .split(":")[0]) -
        int.parse(leaveTime); */
    var missedTime = format
        .parse(widget.homeModels.data.shiftData.times.startCheckOut)
        .difference(
            format.parse("${selectedTime.hour}:${selectedTime.minute}"));

    return ModalProgressHUD(
      inAsyncCall: load,
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: reqType,
                          icon: Container(),
                          style: TextStyle(
                              color: Color(0xff35BCB7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          underline: Container(),
                          onChanged: (String newValue) {
                            setState(() {
                              reqType = newValue;
                            });
                          },
                          items: <String>[
                            'vacation'.tr(),
                            'leave'.tr(),
                            'upnormal'.tr()
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(value.toUpperCase(),
                                    style: TextStyle(
                                        color: Color(0xff35BCB7),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
              (reqType != "vacation".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                value: vacType,
                                icon: Container(),
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                underline: Container(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    vacType = newValue;
                                  });
                                },
                                items: <String>[
                                  'regular'.tr(),
                                  'irregular'.tr(),
                                  'sick'.tr(),
                                  'advance'.tr()
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(value.toUpperCase(),
                                          style: TextStyle(
                                              color: Color(0xff35BCB7),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
              (reqType != "vacation".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          showCalenderStart();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                                "${DateFormat("MMMM dd, yyyy").format(startDate)}",
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
              (reqType != "vacation".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          showCalenderend();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                                "${DateFormat("MMMM dd, yyyy").format(endDate)}",
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
              (reqType != "vacation".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("$no_days " + "days".tr(),
                            style: TextStyle(
                                color: Color(0xff35BCB7),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ),
              (reqType != "leave".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Text("Leave Hour".tr(),
                          style: TextStyle(
                              color: Color(0xff35BCB7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
              (reqType != "leave".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: GestureDetector(
                            onTap: () => _selectTime(context),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      "${selectedTime.hour}:${selectedTime.minute}",
                                      style: TextStyle(
                                          color: Color(0xff35BCB7),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ),
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Color(0xff35BCB7),
                                )
                              ],
                            ),
                          )),
                    ),
              (reqType != "leave".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                            "Missed Time".tr() +
                                ": " +
                                missedTime.toString().split(".")[0],
                            style: TextStyle(
                                color: Color(0xff35BCB7),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ),
                    ),
              (reqType == "upnormal".tr())
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          controller: reason,
                          validator: (val) =>
                              (val.isEmpty) ? "enter_resn".tr() : null,
                          cursorColor: Color(0xff35BCB7),
                          style: TextStyle(
                              color: Color(0xff35BCB7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                              hintText: "resn".tr(),
                              hintStyle: TextStyle(
                                  color: Color(0xff35BCB7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());

                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        if (reqType == "vacation".tr()) {
                          if (endDate.isAfter(startDate) ||
                              endDate.isAtSameMomentAs(startDate)) {
                            setState(() {
                              load = true;
                            });

                            var par = RequestParameters(
                                compId: UserDataShared.comid,
                                empId: UserDataShared.emid,
                                fcmToken: UserDataShared.token,
                                endDate:
                                    DateFormat("yyyy-MM-dd").format(endDate),
                                startDate:
                                    DateFormat("yyyy-MM-dd").format(startDate),
                                lang: (context.locale == Locale("ar"))
                                    ? "ar"
                                    : "en",
                                noOfDays: endDate.difference(startDate).inDays,
                                reason: reason.text,
                                vacType: vacType == "regular".tr()
                                    ? "regular"
                                    : vacType == "irregular".tr()
                                        ? "irregular"
                                        : vacType == "sick".tr()
                                            ? "sick"
                                            : "advance");

                            var res = await service.newRequest(par);

                            setState(() {
                              load = false;
                            });

                            if (!res.error) {
                              _showMyDialog(res.data.data.vacId.toString());
                            } else {
                              Fluttertoast.showToast(
                                  msg: res.data.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'endDateShould'.tr(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else if (reqType == "leave".tr()) {
                          setState(() {
                            load = true;
                          });
                          var now = new DateTime.now();
                          var formatter = new DateFormat('yyyy-MM-dd');
                          String formattedDate = formatter.format(now);

                          var par = LeavesParameters(
                            compId: UserDataShared.comid,
                            empId: UserDataShared.emid,
                            fcmToken: UserDataShared.token,
                            lang: context.locale == Locale("ar") ? "ar" : "en",
                            leaveDate: formattedDate,
                            leaveReason: reason.text,
                            leaveTime:
                                "${selectedTime.hour}:${selectedTime.minute}:00",
                            missedTime: missedTime.toString().split(".")[0],
                          );

                          var res = await service.leavesRequest(par);

                          if (!res.error) {
                            _showMyDialog(res.data.data.leaveId.toString());
                          } else {
                            Fluttertoast.showToast(
                                msg: res.data.message,
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
                          setState(() {
                            load = true;
                          });
                          var locationData = await location.getLocation();

                          double distanceBetween = Geolocator.distanceBetween(
                              locationData.latitude,
                              locationData.longitude,
                              double.parse(
                                  widget.homeModels.data.branchData.lat),
                              double.parse(
                                  widget.homeModels.data.branchData.long));

                          var par = UpnormalParameters(
                              compId: UserDataShared.comid,
                              empId: UserDataShared.emid,
                              away: distanceBetween.toStringAsFixed(2),
                              fcmToken: UserDataShared.token,
                              lang:
                                  context.locale == Locale("ar") ? "ar" : "en",
                              upnormalLat: locationData.latitude.toString(),
                              upnormalLong: locationData.longitude.toString());

                          var res = await service.upnormalRequest(par);

                          if (!res.error) {
                            _showMyDialog(res.data.data.upnormalId.toString());
                          } else {
                            Fluttertoast.showToast(
                                msg: res.data.message,
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
                        }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "send".tr(),
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
                      ],
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

  void showCalenderStart() {
    showDatePicker(
            locale: context.locale,
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((value) {
      if (value != null) {
        setState(() {
          startDate = value;
          no_days = endDate.difference(startDate).inDays + 1;
          print(startDate);
          print(endDate);
          print(no_days);
        });
      }
    });
  }

  void showCalenderend() {
    showDatePicker(
            locale: context.locale,
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((value) {
      if (value != null &&
          (value.isAfter(startDate) || value.isAtSameMomentAs(startDate))) {
        setState(() {
          endDate = value;
          no_days = endDate.difference(startDate).inDays + 1;
          print(startDate);
          print(endDate);
          print(no_days);
        });
      }
    });
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "cong".tr(),
                  style: TextStyle(
                    color: Color(0xff35BCB7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                /* Text(
                  "yourid".tr(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  id,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ), */
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "ok".tr(),
                  style: TextStyle(color: Color(0xff35BCB7)),
                ))
          ],
        );
      },
    );
  }
}
