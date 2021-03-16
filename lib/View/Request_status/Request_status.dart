import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/Request_st_par.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RequestStatusPage extends StatefulWidget {
  @override
  _RequestStatusPageState createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {
  APIService service = APIService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController requestType = TextEditingController();
  TextEditingController req_id = TextEditingController();

  bool load = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: load,
      child: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: requestType,
                    validator: (val) => (val.isEmpty) ? "EnterReq".tr() : null,
                    cursorColor: Color(0xff35BCB7),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                        hintText: "reqTyp".tr(),
                        hintStyle: TextStyle(
                            color: Color(0xff35BCB7),
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: req_id,
                    keyboardType: TextInputType.number,
                    validator: (val) => (val.isEmpty) ? "enter_req".tr() : null,
                    cursorColor: Color(0xff35BCB7),
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                        hintText: "req_id".tr(),
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
                      setState(() {
                        load = true;
                      });

                      var par = RequestStatPar(
                          compId: UserDataShared.comid,
                          empId: UserDataShared.emid,
                          fcmToken: UserDataShared.token,
                          lang: (context.locale == Locale("ar")) ? "ar" : "en",
                          requestType: requestType.text,
                          requestId: req_id.text);

                      var res = await service.requestStatus(par);

                      setState(() {
                        load = false;
                      });

                      if (!res.error) {
                        _showMyDialog(res.data.data.vacId);
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

  Future<void> _showMyDialog(int status) async {
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
                  (status == 0) ? "reject".tr() : "accept".tr(),
                  style: TextStyle(
                    color: (status == 0) ? Colors.red : Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
