import 'package:frontend/DataProvider/Auth/Auth.dart';
import 'package:frontend/Models/LoginModel.dart';
import 'package:frontend/Models/User.dart';

class AuthRepository {

  //Register Repo

  static Future<User> RegisterUserRepo(User user) async {
    return await ClientAuthDataProvider.register(user);
  }
  

  //Login Repo

  static Future<String> LoginUserRepo(LoginModel loginModel) async {
    return await ClientAuthDataProvider.login(loginModel);
  }



}
