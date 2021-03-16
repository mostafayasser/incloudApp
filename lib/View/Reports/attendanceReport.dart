import 'package:attendanceapp/models/attendanceReportModel.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:attendanceapp/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AttendanceReportPage extends StatefulWidget {
  @override
  _AttendanceReportPageState createState() => _AttendanceReportPageState();
}

class _AttendanceReportPageState extends State<AttendanceReportPage> {
  final APIService service = APIService();
  bool report = false;
  String month = DateTime.now().month < 10
          ? "0${DateTime.now().month}"
          : DateTime.now().month.toString(),
      year = DateTime.now().year.toString();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text("Select a month"),
              items: <String>[
                '01',
                '02',
                '03',
                '04',
                '05',
                '06',
                '07',
                '08',
                '09',
                '10',
                '11',
                '12'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              value: month,
              onChanged: (value) {
                setState(() {
                  month = value;
                });
              },
            ),
            DropdownButton<String>(
              hint: Text("Select a year"),
              items: <String>[
                DateTime.now().year.toString(),
                (DateTime.now().year - 1).toString()
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              value: year,
              onChanged: (value) {
                setState(() {
                  year = value;
                });
              },
            ),
          ],
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
            future: service.getAttendanceReport(
                month: month, year: year, locale: context.locale),
            builder: (context,
                AsyncSnapshot<APIResponse<AttendanceReport>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.data.data == null) {
                return Text("no_data".tr());
              }

              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  /* border: Border.all(
                    width: 1,
                  ), */
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(1.7),
                    2: FlexColumnWidth(1.7),
                    3: FlexColumnWidth(1.3),
                    4: FlexColumnWidth(1.3),
                  },
                  /* border: TableBorder.symmetric(
                    inside: BorderSide(width: 1),
                  ), */
                  children: [
                    TableRow(children: [
                      Title(
                          title: 'Date'.tr(),
                          fontSize: 14.0,
                          padding: const EdgeInsets.all(8.0)),
                      Title(
                          title: 'Checkin Date'.tr(),
                          fontSize:
                              context.locale == Locale("en") ? 10.0 : 12.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10)),
                      Title(
                          title: 'Checkout Date'.tr(),
                          fontSize: context.locale == Locale("en") ? 9.0 : 11.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.5)),
                      Title(
                          title: 'Work Hours'.tr(),
                          fontSize: 8.0,
                          padding: context.locale == Locale("en")
                              ? const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 11.5)
                              : const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 13)),
                      Title(
                          title: 'Overtime'.tr(),
                          fontSize: 10.0,
                          padding: context.locale == Locale("en")
                              ? const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10)
                              : const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 12)),
                    ]),
                    ...List.generate(
                        snapshot.data.data.attendanceRecords.length,
                        (index) => TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data.data.attendanceRecords[index]
                                            .date
                                            .substring(5) ??
                                        "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data.data.attendanceRecords[index]
                                                .checkInDate ==
                                            ""
                                        ? ""
                                        : snapshot
                                            .data
                                            .data
                                            .attendanceRecords[index]
                                            .checkInDate
                                            .substring(5, 16),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data.data.attendanceRecords[index]
                                                .checkOutDate ==
                                            ""
                                        ? ""
                                        : snapshot
                                            .data
                                            .data
                                            .attendanceRecords[index]
                                            .checkOutDate
                                            .substring(5, 16),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.data.attendanceRecords[index]
                                              .workHours ==
                                          ""
                                      ? ""
                                      : snapshot.data.data
                                          .attendanceRecords[index].workHours
                                          .substring(0, 5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.data.attendanceRecords[index]
                                              .overtime ==
                                          ""
                                      ? ""
                                      : snapshot.data.data
                                          .attendanceRecords[index].overtime
                                          .substring(0, 5),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]))
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  final title;
  final fontSize;
  final padding;
  const Title({Key key, this.title, this.fontSize, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: EdgeInsets.symmetric(horizontal: 2),
      color: Colors.grey[800],
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}
