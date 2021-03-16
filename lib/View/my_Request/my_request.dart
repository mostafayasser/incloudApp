import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/my_req_models.dart';
import 'package:attendanceapp/models/my_request_parameter.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class MyRequestPage extends StatefulWidget {
  final String lang;
  MyRequestPage(this.lang);
  @override
  _MyRequestPageState createState() => _MyRequestPageState();
}

class _MyRequestPageState extends State<MyRequestPage> {
  DateTime current = DateTime.now();
  bool load = false;
  MyRequestModels requestModels;
  APIService service = APIService();
  @override
  void initState() {
    getData(
        DateTime.now().month.toString(), DateTime.now().year.toString(), false);
    super.initState();
  }

  void getData(String month, String year, bool displayError) async {
    if (month.length == 1) {
      month = "0$month";
    }
    if (mounted) {
      setState(() {
        load = true;
      });

      var par = MyRequestParameters(
          month: month,
          year: year,
          lang: widget.lang,
          fcmToken: UserDataShared.token,
          compId: UserDataShared.comid,
          empId: UserDataShared.emid);

      var res = await service.myRequest(par);

      if (!res.error) {
        requestModels = res.data;
      } else {
        requestModels = null;
        if (displayError) {
          Fluttertoast.showToast(
              msg: res.data.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }

      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (load)
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Center(
                  child: SpinKitThreeBounce(
                    color: Color(0xff35BCB7),
                    size: 30,
                  ),
                ),
              )
            : (requestModels == null ||
                    ((requestModels.data.vacs.length == 0 ||
                            requestModels.data.vacs == null) &&
                        (requestModels.data.leaves.length == 0 ||
                            requestModels.data.leaves == null) &&
                        (requestModels.data.upnormalRequests.length == 0 ||
                            requestModels.data.upnormalRequests == null)))
                ? Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      child: Center(
                          child: Text(
                        "Nodata".tr(),
                        style:
                            TextStyle(color: Color(0xff35BCB7), fontSize: 18),
                      )),
                    ),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      (requestModels.data.vacs.length == 0 ||
                              requestModels.data.vacs == null)
                          ? Container()
                          : Center(
                              child: Text(
                                "Vacations".tr(),
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      (requestModels.data.vacs.length == 0 ||
                              requestModels.data.vacs == null)
                          ? Container()
                          : SizedBox(
                              height: 10,
                            ),
                      (requestModels.data.vacs.length == 0 ||
                              requestModels.data.vacs == null)
                          ? Container()
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: requestModels.data.vacs.length,
                              itemBuilder: (context, i) {
                                return Vacations(requestModels.data.vacs[i]);
                              }),
                      (requestModels.data.vacs.length == 0 ||
                              requestModels.data.vacs == null)
                          ? Container()
                          : SizedBox(
                              height: 15,
                            ),
                      (requestModels.data.leaves.length == 0 ||
                              requestModels.data.leaves == null)
                          ? Container()
                          : Center(
                              child: Text(
                                "Leaves".tr(),
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      (requestModels.data.leaves.length == 0 ||
                              requestModels.data.leaves == null)
                          ? Container()
                          : SizedBox(
                              height: 10,
                            ),
                      (requestModels.data.leaves.length == 0 ||
                              requestModels.data.leaves == null)
                          ? Container()
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: requestModels.data.leaves.length,
                              itemBuilder: (context, i) {
                                return LeavesV(requestModels.data.leaves[i]);
                              }),
                      (requestModels.data.leaves.length == 0 ||
                              requestModels.data.leaves == null)
                          ? Container()
                          : SizedBox(
                              height: 15,
                            ),
                      (requestModels.data.upnormalRequests.length == 0 ||
                              requestModels.data.upnormalRequests == null)
                          ? Container()
                          : Center(
                              child: Text(
                                "Upnormal".tr(),
                                style: TextStyle(
                                    color: Color(0xff35BCB7),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      (requestModels.data.upnormalRequests.length == 0 ||
                              requestModels.data.upnormalRequests == null)
                          ? Container()
                          : SizedBox(
                              height: 10,
                            ),
                      (requestModels.data.upnormalRequests.length == 0 ||
                              requestModels.data.upnormalRequests == null)
                          ? Container()
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  requestModels.data.upnormalRequests.length,
                              itemBuilder: (context, i) {
                                return Upnormal(
                                    requestModels.data.upnormalRequests[i]);
                              }),
                      (requestModels.data.upnormalRequests.length == 0 ||
                              requestModels.data.upnormalRequests == null)
                          ? Container()
                          : SizedBox(
                              height: 15,
                            ),
                    ],
                  ),
        Container(
          height: 80,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          DateFormat("MMMM, yyyy").format(current),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    getData(current.month.toString(), current.year.toString(),
                        true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff35BCB7),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Icon(
                        Icons.find_in_page,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker() {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 1),
      lastDate: DateTime(DateTime.now().year + 1, 12),
      initialDate: DateTime.now(),
      locale: context.locale,
    ).then((date) {
      if (date != null) {
        setState(() {
          current = date;
        });
      }
    });
  }
}

class Vacations extends StatelessWidget {
  final Vacs vacs;
  Vacations(this.vacs);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "type".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacs.vacType.toLowerCase().tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "start".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacs.startDate,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "end".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacs.endDate,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "no_days".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacs.noOfDays.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "reason".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacs.reason,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "status".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (vacs.status == 0)
                        ? "suspend".tr()
                        : (vacs.status == 1)
                            ? "accept".tr()
                            : "reject".tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeavesV extends StatelessWidget {
  final Leaves leavesV;
  LeavesV(this.leavesV);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "leave_date".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    leavesV.leaveDate,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "missed_date".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    leavesV.missedTime,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "reason".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    leavesV.leaveReason,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "status".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (leavesV.confirmed == 0)
                        ? "suspend".tr()
                        : (leavesV.confirmed == 1)
                            ? "accept".tr()
                            : "reject".tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Upnormal extends StatelessWidget {
  final UpnormalRequests upnormalRequests;
  Upnormal(this.upnormalRequests);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              /* Row(
                children: [
                  Text(
                    "type".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    upnormalRequests.upnormalType,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ), */
              Row(
                children: [
                  Text(
                    "Date".tr() + ": ",
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    upnormalRequests.upnormalTime,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "status".tr(),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (upnormalRequests.status == 0)
                        ? "suspend".tr()
                        : (upnormalRequests.status == 1)
                            ? "accept".tr()
                            : "reject".tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
