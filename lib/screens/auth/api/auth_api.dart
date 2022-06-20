import 'package:flutter_demo_auth/app/constants/errors_const.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';

class AuthApi {
  Future<Map<String, dynamic>> authorization({required Login login}) async {
    Map<String, dynamic> answer = {
      'status': false,
      'error_message': '',
    };
    const String correctLogin = '+79200001515';
    const String correctPass = 'Password13';

    // Выполняем логику провекрки авторизации здесь, так как нет реального взаимодействия с API
    await Future.delayed(const Duration(seconds: 2), () {
      if (login.phone != correctLogin) {
        answer['error_message'] = ServerErrors.phoneError;
      } else if (login.phone == correctLogin && login.password != correctPass) {
        answer['error_message'] = ServerErrors.passwordError;
      } else if (login.phone == correctLogin && login.password == correctPass) {
        answer['error_message'] = '';
        answer['status'] = true;
      }
    });

    return answer;
  }
}
