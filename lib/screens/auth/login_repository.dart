// Project imports:
import 'package:flutter_demo_auth/screens/auth/api/auth_api.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/services/exceptions/common_error_model.dart';
import 'package:flutter_demo_auth/services/exceptions/exceptions.dart';
import 'package:flutter_demo_auth/services/shared_preferences.dart';

class LoginRepository {
  Future<Map<String, dynamic>> userLogin({
    required Login login,
  }) async {
    Map<String, dynamic> res = await AuthApi().authorization(login: login);

    if (res['status'] == true) {
      // Сохраняем необходимые для быстрого доступа данные
      await SharedStorageService.setString(
          PreferenceKey.phoneNumber, login.phone);
      await SharedStorageService.setBool(PreferenceKey.isLoggedIn, true);
    } else {
      throw LoginException(
          CommonError(success: false, error: res['error_message']));
    }

    return res;
  }
}
