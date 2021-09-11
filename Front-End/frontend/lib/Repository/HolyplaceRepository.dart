import 'package:frontend/DataProvider/Holyplace/Holyplace.dart';
import 'package:frontend/Models/models.dart';

class HolyPlaceRepository {
  static Future<dynamic> getAllHolyplaces() async {
    print("passed holyplace iiii repo");
    return await HolyPlaceDataProvovider.getAllHolyplaces();
  }

  static Future<dynamic> createHolyPlace(HolyplaceModel holyplaceModel) async {
    print("passed holyplace iii repo");
    return await  HolyPlaceDataProvovider.createHolyPlace(holyplaceModel);
  }

}
