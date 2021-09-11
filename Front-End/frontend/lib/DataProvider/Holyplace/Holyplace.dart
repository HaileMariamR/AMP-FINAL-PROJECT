import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/Models/models.dart';

class HolyPlaceDataProvovider {
  static Future<dynamic> getAllHolyplaces() async {
    List holyplaces = [];

    try {
      final httpresponse = await http.get(
        Uri.parse('http://localhost:3500/api/getallholyplaces'),
      );

      if (httpresponse.statusCode == 200) {
        var finalresult = jsonDecode(httpresponse.body);
        holyplaces = finalresult['holyplaces'];
      }
    } catch (e) {}

    return holyplaces;
  }

  static Future<dynamic> createHolyPlace(HolyplaceModel holyplaceModel) async {
    var responsemessage = "";

    try {
      print("on dataprovider");

      final response = await http
          .post(Uri.parse('http://localhost:3500/api/createHolyPlace'), body: {
        'createdby': holyplaceModel.createtor_id.toString(),
        'name': holyplaceModel.nameofholyplace.toString(),
        'location': holyplaceModel.location.toString(),
        'history': holyplaceModel.history.toString(),
        'image': holyplaceModel.imageUrl.toString()
      });
      print(holyplaceModel.createtor_id);
      responsemessage = jsonDecode(response.body).toString();
      print("response: $responsemessage");
    } catch (e) {
      print(e.toString());
    }
    return responsemessage;
  }
}
