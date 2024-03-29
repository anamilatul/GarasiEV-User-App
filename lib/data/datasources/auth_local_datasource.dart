import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response_model.dart';

class AuthLocalDataSource {
  Future<bool> saveAuth(AuthResponseModel model) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = await preferences.setString('auth', model.toJson());
    return result;
  }

  Future<bool> removeAuth() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final result = await preferences.remove('auth');
    return result;
  }

  Future<String> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final authJson = preferences.getString('auth') ?? '';
    final authModel = AuthResponseModel.fromJson(authJson);
    return authModel.token;
  }

  Future<bool> isLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final authJson = preferences.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }

  Future<int> getUserId() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final authJson = preferences.getString('auth') ?? '';
    if (authJson.isNotEmpty) {
      final authModel = AuthResponseModel.fromJson(authJson);
      return authModel.user.id;
    } else {
      return -1;
    }
  }
  // Future<int> getUserId() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final authJson = preferences.getString('auth') ?? '';

  //   if (authJson.isNotEmpty) {
  //     final authModel = AuthResponseModel.fromJson(authJson);

  //     if (authModel.user != null) {
  //       return authModel.user.id ??
  //           -1; // Menggunakan nilai default -1 jika id null
  //     } else {
  //       return -1;
  //     }
  //   } else {
  //     return -1;
  //   }
  // }
}
