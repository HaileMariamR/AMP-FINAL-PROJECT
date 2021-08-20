import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend/Models/User.dart';
import 'package:frontend/Models/LoginModel.dart';

import '../../Utilities/Constants.dart';

//Genymotion emulator address 192.168.60.1

class ClientAuthDataProvider {
// RegisterUser DataProvider

  static Future<User> register(User user) async {
    User getCurrentUser = User("", "");
    try {
      final httpresponse = await http.post(
          Uri.parse('$API_URL/RegisterUser'),
          body: user.tojson());
      if (httpresponse.statusCode == 201) {
        var incommingvalue = jsonDecode(httpresponse.body);
        getCurrentUser = User(
          incommingvalue['emailAddress'],
          incommingvalue['password'],
          userName: incommingvalue['userName'],
          fullName: incommingvalue['fullName'],
          confirmPassword: incommingvalue['confirmPassword'],
        );
      }

      print("passed dataprovider");
    } catch (e) {
      print(e.toString());
    }

    return getCurrentUser;
  }

// Login DataProvider

  static Future<Map<String, dynamic>> login(LoginModel loginModel) async {
    var finalvalue;

    try {
      final httpresponse = await http.post(
          Uri.parse('http://localhost:3500/api/LoginUser'),
          body: loginModel.tojson());

      if (httpresponse.statusCode == 200) {
        finalvalue = jsonDecode(httpresponse.body);
      } else if (httpresponse.statusCode == 400) {
        finalvalue = jsonDecode(httpresponse.body);
      }
    } catch (e) {
      print(e.toString());
    }

    return finalvalue;
  }

// DeleteUser DataProvider

  static Future<String> deleteaccount(User user, String accesstoken) async {
    var result = "";

    try {
      print("at DataProvider");
      print(user.tojson());
      print(accesstoken);

      final httpresponse = await http.delete(
        Uri.parse('http://localhost:3500/api/DeleteProfile'),
        body: {
          "emailAddress": user.tojson()['emailAddress'],
        },
        headers: {"Authorization": "${accesstoken}"},
      );
      print("sent delete request");
      if (httpresponse.statusCode == 200) {
        result = jsonDecode(httpresponse.body).toString();
      } else if (httpresponse.statusCode == 400) {
        result = jsonDecode(httpresponse.body).toString();
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
