import 'package:attendanceapp/View/Reports/attendanceReport.dart';
import 'package:attendanceapp/View/Reports/salaryReport.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool salaryChosen = false;
  bool noChoice = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "attendance_report".tr(),
                  style: TextStyle(
                      color: salaryChosen
                          ? Colors.black
                          : noChoice
                              ? Colors.black
                              : Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    salaryChosen = false;
                    noChoice = false;
                  });
                },
                color: noChoice
                    ? Colors.white
                    : salaryChosen
                        ? Colors.white
                        : Colors.blue,
              ),
              SizedBox(
                width: 30,
              ),
              RaisedButton(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "salary_report".tr(),
                  style: TextStyle(
                      color: salaryChosen ? Colors.white : Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    salaryChosen = true;
                    noChoice = false;
                  });
                },
                color: noChoice
                    ? Colors.white
                    : salaryChosen
                        ? Colors.blue
                        : Colors.white,
              ),
            ],
          ),
          noChoice
              ? Container()
              : salaryChosen
                  ? SalaryReportPage()
                  : AttendanceReportPage()
        ],
      ),
    );
  }
}
