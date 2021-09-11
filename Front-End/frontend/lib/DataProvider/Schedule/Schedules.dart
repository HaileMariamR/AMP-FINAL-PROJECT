import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:frontend/Models/Schedule.dart';

class SchedulesDataProvovider {
  static Future<dynamic> getAllSchedules() async {
    dynamic schedules;
    try {
      final httpresponse = await http.get(
        Uri.parse('http://localhost:3500/api/getallSchedules'),
      );

      if (httpresponse.statusCode == 200) {
        var finalresult = jsonDecode(httpresponse.body);
        schedules = finalresult['Schedules'];
        // print(finalresult['Schedules']);
      }
    } catch (e) {}

    return schedules;
  }

  static Future<dynamic> createSchedule(Schedule schedule) async {
    var responsemessage = "";

    try {
      print(schedule.tojson());
      final response = await http
          .post(Uri.parse('http://localhost:3500/api/createSchedule'), body: {
        'createdby': schedule.createdby.toString(),
        'programs': schedule.allprograms.toString(),
      });
      responsemessage = jsonDecode(response.body).toString();
    } catch (e) {
      print(e.toString());
    }

    return responsemessage;
  }
}
