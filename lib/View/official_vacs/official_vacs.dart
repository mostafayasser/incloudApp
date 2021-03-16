import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/models/official_models.dart';
import 'package:attendanceapp/models/official_response.dart';
import 'package:attendanceapp/services/APIServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';

class OfficialVacss extends StatefulWidget {
  final String lang;
  OfficialVacss(this.lang);
  @override
  _OfficialVacsState createState() => _OfficialVacsState();
}

class _OfficialVacsState extends State<OfficialVacss> {
  bool load = false;
  final APIService service = APIService();
  OfficialResponse officialVacs;

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
          lang:  widget.lang,
          fcmToken: UserDataShared.token,
          compId: UserDataShared.comid,
          empId: UserDataShared.emid);

      var res = await service.officialvacs(par);

      setState(() {
        load = false;
      });

      if (!res.error) {
        officialVacs = res.data;
      } else {
        officialVacs = null;
        
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
        : (officialVacs == null)
            ? Container()
            :(officialVacs.data.officialVacs.length == 0||officialVacs.data.officialVacs == null)?Container(
              child: Center(child: Text("Nodata".tr(),style: TextStyle(color: Color(0xff35BCB7),fontSize: 18),)),
            ): Container(
                child: ListView.builder(
                    itemCount: officialVacs.data.officialVacs.length,
                    itemBuilder: (context, i) {
                      return OffItems(officialVacs.data.officialVacs[i]);
                    }),
              );
  }
}

class OffItems extends StatelessWidget {
  final OfficialVacs officialVacs;
  OffItems(this.officialVacs);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                officialVacs.vacComment,
                style: TextStyle(
                    color: Color(0xff06B5CF),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                officialVacs.vacDate,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
