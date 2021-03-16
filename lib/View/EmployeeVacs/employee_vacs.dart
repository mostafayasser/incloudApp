import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/employee_vacs_models.dart';
import 'package:attendanceapp/models/official_models.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployeeVacs extends StatefulWidget {
  final String lang;
  EmployeeVacs(this.lang);
  @override
  _EmployeeVacsState createState() => _EmployeeVacsState();
}

class _EmployeeVacsState extends State<EmployeeVacs> {
  bool load = false;
  final APIService service = APIService();
  EmployeesVacsModels employeesVacsModels;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (mounted) {
      setState(() {
        load = true;
      });
      var par = Official(
          year: DateTime.now().year.toString(),
          lang: widget.lang,
          fcmToken: UserDataShared.token,
          compId: UserDataShared.comid,
          empId: UserDataShared.emid);

      var res = await service.employeeVacs(par);

      setState(() {
        load = false;
      });

      if (!res.error) {
        employeesVacsModels = res.data;
      } else {
        employeesVacsModels = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (load)
        ? Center(
            child: SpinKitThreeBounce(
              color: Color(0xff35BCB7),
              size: 30,
            ),
          )
        : (employeesVacsModels == null)
            ? Container()
            : ((employeesVacsModels.data.vacsBalance.length == 0 ||
                        employeesVacsModels.data.vacsBalance == null) &&
                    (employeesVacsModels.data.leavesBalance.length == 0 ||
                        employeesVacsModels.data.leavesBalance == null))
                ? Container(
                    child: Center(
                        child: Text(
                      "Nodata".tr(),
                      style: TextStyle(color: Color(0xff35BCB7), fontSize: 18),
                    )),
                  )
                : Container(
                    child: ListView(
                      children: [
                        (employeesVacsModels.data.vacsBalance.length == 0 ||
                                employeesVacsModels.data.vacsBalance == null)
                            ? Container()
                            : Center(
                                child: Text(
                                  "vacationBalance".tr() +
                                      " ${DateTime.now().year}",
                                  style: TextStyle(
                                      color: Color(0xff35BCB7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        (employeesVacsModels.data.vacsBalance.length == 0 ||
                                employeesVacsModels.data.vacsBalance == null)
                            ? Container()
                            : SizedBox(
                                height: 20,
                              ),
                        (employeesVacsModels.data.vacsBalance.length == 0 ||
                                employeesVacsModels.data.vacsBalance == null)
                            ? Container()
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    employeesVacsModels.data.vacsBalance.length,
                                itemBuilder: (context, i) {
                                  return VacsBalanceData(
                                      employeesVacsModels.data.vacsBalance[i]);
                                }),
                        (employeesVacsModels.data.vacsBalance.length == 0 ||
                                employeesVacsModels.data.vacsBalance == null)
                            ? Container()
                            : SizedBox(
                                height: 15,
                              ),
                        (employeesVacsModels.data.leavesBalance.length == 0 ||
                                employeesVacsModels.data.leavesBalance == null)
                            ? Container()
                            : Center(
                                child: Text(
                                  "leaveBala".tr() + " ${DateTime.now().year}",
                                  style: TextStyle(
                                      color: Color(0xff35BCB7),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        (employeesVacsModels.data.leavesBalance.length == 0 ||
                                employeesVacsModels.data.leavesBalance == null)
                            ? Container()
                            : SizedBox(
                                height: 20,
                              ),
                        (employeesVacsModels.data.leavesBalance.length == 0 ||
                                employeesVacsModels.data.leavesBalance == null)
                            ? Container()
                            : Center(
                                child: Wrap(
                                    children: List.generate(
                                        employeesVacsModels
                                            .data.leavesBalance.length,
                                        (index) => LeaveBalanceData(
                                            employeesVacsModels
                                                .data.leavesBalance[index]))),
                              )
                      ],
                    ),
                  );
  }
}

class VacsBalanceData extends StatelessWidget {
  final VacsBalance vacsBalance;
  VacsBalanceData(this.vacsBalance);
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
                    "regular".tr() + ": ",
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacsBalance.regular.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "irregular".tr() + ": ",
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacsBalance.irregular.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "sick".tr() + ": ",
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacsBalance.sick.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "advance".tr() + ": ",
                    style: TextStyle(
                        color: Color(0xff35BCB7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    vacsBalance.advance.toString(),
                    style: TextStyle(fontSize: 16),
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

class LeaveBalanceData extends StatelessWidget {
  final LeavesBalance leavesBalance;
  LeaveBalanceData(this.leavesBalance);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "${DateFormat("MMMM").format(DateTime(DateTime.now().year, leavesBalance.month))}: ${leavesBalance.leaves}",
            style: TextStyle(
                color: Color(0xff35BCB7),
                fontSize: 18,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
