import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend/Models/Schedule.dart';

class SchedulesDataProvovider {
  static Future<dynamic> getAllSchedules() async {
    dynamic schedules;
    try {
      final httpresponse = await http.get(
        Uri.parse('http://localhost:4000/api/getallSchedules'),
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
    dynamic responsemessage;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:4000/api/createSchedule'),
        body: {
          "title": schedule.title,
          "description": schedule.description,
          "createdby": schedule.createdby,
          "programs": schedule.allprograms.toString()
        },
      );
      if (response.statusCode == 403) {
        responsemessage = {"Errormessage": response.body};
      } else if (response.statusCode == 201) {
        print(response.body);
        responsemessage = jsonDecode(response.body);
      } else
        responsemessage = response.body;
    } catch (e) {
      print(e.toString());
    }

    return responsemessage;
  }
}
