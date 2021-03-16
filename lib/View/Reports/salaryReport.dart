import 'package:attendanceapp/models/calc_salary.dart';
import 'package:attendanceapp/models/salary.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:attendanceapp/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SalaryReportPage extends StatefulWidget {
  @override
  _SalaryReportPageState createState() => _SalaryReportPageState();
}

class _SalaryReportPageState extends State<SalaryReportPage> {
  final APIService service = APIService();
  bool report = false;
  String month = "", year = "";

  CalcSalaries selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: service.getCalcSalaries(context.locale),
          builder: (context,
              AsyncSnapshot<APIResponse<CalculateSalaries>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.data.data.data.calcSalaries == null ||
                snapshot.data.data.data.calcSalaries.isEmpty) {
              return Text("no_data".tr());
            } else {
              if (month == "" && year == "") {
                month =
                    snapshot.data.data.data.calcSalaries[0].month.toString();
                year = snapshot.data.data.data.calcSalaries[0].year.toString();
              } else {
                month = month;
                year = year;
              }

              return StatefulBuilder(
                builder: (context, setState) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      hint: Text("Select a salary"),
                      items: snapshot.data.data.data.calcSalaries
                          .map((CalcSalaries calc) {
                            return new DropdownMenuItem<String>(
                              value:
                                  "${calc.month.toString()}-${calc.year.toString()}",
                              child: new Text(
                                  "${calc.month.toString()}-${calc.year.toString()}"),
                            );
                          })
                          .toList()
                          .reversed
                          .toList(),
                      value: "$month-$year",
                      onChanged: (value) {
                        setState(() {
                          month = value.split("-").first;
                          year = value.split("-").last;
                          print(month);
                        });
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
        RaisedButton(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.green,
          child: Text(
            "Get Report".tr(),
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              report = true;
            });
          },
        ),
        if (report)
          FutureBuilder(
            future: service.getEmployeeSalary(
                month: month, year: year, locale: context.locale),
            builder: (context, AsyncSnapshot<APIResponse<Salaries>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.data.data == null) {
                return Text("no_data".tr());
              } else if (snapshot.hasData) {
                int deductionsLength =
                    snapshot.data.data.data.deductions.details.length;
                int earningsLength =
                    snapshot.data.data.data.earning.details.length;
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      color: Colors.grey[200],
                      /* decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ), */
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(2.2),
                          1: FlexColumnWidth(2.2),
                          2: FlexColumnWidth(2.2),
                        },
                        /* border: TableBorder.symmetric(
                          inside: BorderSide(width: 1),
                        ), */
                        children: [
                          TableRow(children: [
                            Title(
                              title: 'Earnings'.tr(),
                            ),
                            Title(
                              title: 'Deductions'.tr(),
                            ),
                          ]),
                          ...List.generate(
                              deductionsLength > earningsLength
                                  ? deductionsLength
                                  : earningsLength,
                              (index) => TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(index >= earningsLength
                                          ? ""
                                          : snapshot.data.data.data.earning
                                                  .details[index].amount
                                                  .toString() +
                                              " (${snapshot.data.data.data.earning.details[index].reason})"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(index >= deductionsLength
                                          ? ""
                                          : snapshot.data.data.data.deductions
                                                  .details[index].amount
                                                  .toString() +
                                              " (${snapshot.data.data.data.deductions.details[index].reason})"),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Net Salary".tr() +
                            ":" +
                            " ${snapshot.data.data.data.netSalary}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final title;

  const Title({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 2),
      color: Colors.grey[800],
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
