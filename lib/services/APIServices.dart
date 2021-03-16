import 'dart:async';
import 'dart:ui';

import 'package:attendanceapp/models/Check_In_data.dart';
import 'package:attendanceapp/models/Check_Out_Parameters.dart';
import 'package:attendanceapp/models/Request_parameters.dart';
import 'package:attendanceapp/models/Request_st_par.dart';
import 'package:attendanceapp/models/attendanceReportModel.dart';
import 'package:attendanceapp/models/calc_salary.dart';
import 'package:attendanceapp/models/change_parameters.dart';
import 'package:attendanceapp/models/checkOut_data.dart';
import 'package:attendanceapp/models/check_in_Parameters.dart';
import 'package:attendanceapp/models/employee_vacs_models.dart';
import 'package:attendanceapp/models/home_models.dart';
import 'package:attendanceapp/models/home_prameters_models.dart';
import 'package:attendanceapp/models/leave_parameters.dart';
import 'package:attendanceapp/models/leaves_models.dart';
import 'package:attendanceapp/models/my_req_models.dart';
import 'package:attendanceapp/models/my_request_parameter.dart';
import 'package:attendanceapp/models/new_request.dart';
import 'package:attendanceapp/models/official_models.dart';
import 'package:attendanceapp/models/official_response.dart';
import 'package:attendanceapp/models/profile_data.dart';
import 'package:attendanceapp/models/profile_data_parameters.dart';
import 'package:attendanceapp/models/salary.dart';
import 'package:attendanceapp/models/serverTime.dart';
import 'package:attendanceapp/models/suspended_vacs.dart';
import 'package:attendanceapp/models/upnormal_models.dart';
import 'package:attendanceapp/models/upnormal_para.dart';
import 'package:attendanceapp/models/userConnection.dart';
import 'package:attendanceapp/models/userSignedParameter.dart';
import 'package:attendanceapp/models/DataShared.dart';
import 'package:attendanceapp/services/api_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static String apiRoot = "https://www.i-techeg.com/";
  static const headers = {"content-type": 'application/json'};

  Future<APIResponse<UserSigned>> login(UserSignedParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_verification.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        printInfo(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);
        print(jsonData);
        if (data.statusCode == 200) {
          return APIResponse<UserSigned>(data: UserSigned.fromJson(jsonData));
        }
        return APIResponse<UserSigned>(
            data: UserSigned.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<UserSigned>(error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<HomeModels>> homeData(HomeParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_home.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        printInfo(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);
        printInfo(json.encode(item.toJson()));
        if (data.statusCode == 200) {
          return APIResponse<HomeModels>(data: HomeModels.fromJson(jsonData));
        }
        return APIResponse<HomeModels>(
            data: HomeModels.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<HomeModels>(error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<OfficialResponse>> officialvacs(Official item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_official_vacations.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<OfficialResponse>(
              data: OfficialResponse.fromJson(jsonData));
        }
        return APIResponse<OfficialResponse>(
            data: OfficialResponse.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<OfficialResponse>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<EmployeesVacsModels>> employeeVacs(Official item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_vacations_leaves_balance.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<EmployeesVacsModels>(
              data: EmployeesVacsModels.fromJson(jsonData));
        }
        return APIResponse<EmployeesVacsModels>(
            data: EmployeesVacsModels.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<EmployeesVacsModels>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<MyRequestModels>> myRequest(MyRequestParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_my_requests.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<MyRequestModels>(
              data: MyRequestModels.fromJson(jsonData));
        }
        return APIResponse<MyRequestModels>(
            data: MyRequestModels.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<MyRequestModels>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<NewRequestModels>> newRequest(RequestParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_new_vac_request.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print("Vaction Body: ${json.encode(item.toJson())}");
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<NewRequestModels>(
              data: NewRequestModels.fromJson(jsonData));
        }
        return APIResponse<NewRequestModels>(
            data: NewRequestModels.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<NewRequestModels>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<LeavesModel>> leavesRequest(LeavesParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_new_leave_request.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<LeavesModel>(data: LeavesModel.fromJson(jsonData));
        }
        return APIResponse<LeavesModel>(
            data: LeavesModel.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<LeavesModel>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<UpnormalModels>> upnormalRequest(UpnormalParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_new_upnormal_request.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<UpnormalModels>(
              data: UpnormalModels.fromJson(jsonData));
        }
        return APIResponse<UpnormalModels>(
            data: UpnormalModels.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<UpnormalModels>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<RequestStatus>> requestStatus(RequestStatPar item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_my_suspended_requests.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<RequestStatus>(
              data: RequestStatus.fromJson(jsonData));
        }
        return APIResponse<RequestStatus>(
            data: RequestStatus.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<RequestStatus>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<AttendsCheck>> requestCheckin(CheckInParmeters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_trans_checkinout.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<AttendsCheck>(
              data: AttendsCheck.fromJson(jsonData));
        }
        return APIResponse<AttendsCheck>(
            data: AttendsCheck.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<AttendsCheck>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<AttendsCheckOut>> requestCheckOut(
      CheckOutParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_trans_checkinout.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<AttendsCheckOut>(
              data: AttendsCheckOut.fromJson(jsonData));
        }
        return APIResponse<AttendsCheckOut>(
            data: AttendsCheckOut.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<AttendsCheckOut>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<AttendsCheckOut>> requestChangePassword(
      ChangesParameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_change_pass.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<AttendsCheckOut>(
              data: AttendsCheckOut.fromJson(jsonData));
        }
        return APIResponse<AttendsCheckOut>(
            data: AttendsCheckOut.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<AttendsCheckOut>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<ProfileData>> getUserData(Profile_Parameters item) {
    try {
      return http
          .post('${apiRoot}ihr/mob/api_profile_data.php',
              headers: headers, body: json.encode(item.toJson()))
          .then((data) {
        print(json.encode(item.toJson()));
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<ProfileData>(data: ProfileData.fromJson(jsonData));
        }
        return APIResponse<ProfileData>(
            data: ProfileData.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<ProfileData>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<AttendanceReport>> getAttendanceReport(
      {month, year, locale}) {
    try {
      if (int.parse(month) > DateTime.now().month &&
          int.parse(year) == DateTime.now().year)
        month = DateTime.now().month.toString();
      final body = {
        "emp_id": UserDataShared.emid,
        "comp_id": UserDataShared.comid,
        "lang": locale == Locale("ar") ? "ar" : "en",
        "fcm_token": UserDataShared.token,
        "year": year,
        "month": month
      };
      return http
          .post('${apiRoot}ihr/mob/api_attend_summary.php',
              headers: headers, body: json.encode(body))
          .then((data) {
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<AttendanceReport>(
              data: AttendanceReport.fromJson(jsonData));
        }
        return APIResponse<AttendanceReport>(
            data: AttendanceReport.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<AttendanceReport>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<CalculateSalaries>> getCalcSalaries(locale) {
    try {
      final body = {
        "emp_id": UserDataShared.emid,
        "comp_id": UserDataShared.comid,
        "lang": locale == Locale("ar") ? "ar" : "en",
        "fcm_token": UserDataShared.token,
      };
      return http
          .post('${apiRoot}ihr/mob/api_calc_salaries.php',
              headers: headers, body: json.encode(body))
          .then((data) {
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<CalculateSalaries>(
              data: CalculateSalaries.fromJson(jsonData));
        }
        return APIResponse<CalculateSalaries>(
            data: CalculateSalaries.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<CalculateSalaries>(
            error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<Salaries>> getEmployeeSalary({month, year, locale}) {
    try {
      final body = {
        "emp_id": UserDataShared.emid,
        "comp_id": UserDataShared.comid,
        "lang": locale == Locale("ar") ? "ar" : "en",
        "fcm_token": UserDataShared.token,
        "year": year,
        "month": month
      };
      return http
          .post('${apiRoot}ihr/mob/api_emp_salary.php',
              headers: headers, body: json.encode(body))
          .then((data) {
        final jsonData = json.decode(data.body);

        if (data.statusCode == 200) {
          return APIResponse<Salaries>(data: Salaries.fromJson(jsonData));
        }
        return APIResponse<Salaries>(
            data: Salaries.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<Salaries>(error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }

  Future<APIResponse<ServerTime>> getServerTime() {
    try {
      final body = {};
      return http
          .post(
        '${apiRoot}ihr/mob/api_server_time.php',
        headers: headers,
      )
          .then((data) {
        final jsonData = json.decode(data.body);
        print(jsonData);
        if (data.statusCode == 200) {
          return APIResponse<ServerTime>(data: ServerTime.fromJson(jsonData));
        }
        return APIResponse<ServerTime>(
            data: ServerTime.fromJson(jsonData), error: true);
      }).catchError((e) {
        printInfo(e.toString());
        return APIResponse<ServerTime>(error: true, errorMessage: e.toString());
      });
    } catch (e) {
      print('Server error');
    }
  }
}
