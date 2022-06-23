// Project imports:
import 'package:flutter_demo_auth/app/constants/errors_const.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/services/encryption.dart';
import 'package:flutter_demo_auth/services/hive_service.dart';

class AuthApi {
  Future<Map<String, dynamic>> authorization({required Login login}) async {
    Map<String, dynamic> answer = {
      'status': false,
      'error_message': '',
    };

    // Получим данные из Hive
    List<Login> userList = HiveService.getUsers();

    if (userList.isEmpty) {
      answer['error_message'] = ServerErrors.phoneError;
    } else {
      for (var i = 0; i < userList.length; i++) {
        // Пользователь существует, вернем статус ошибки
        if (userList[i].phone == login.phone &&
            (userList[i].password ==
                EncryptHelper.generateMd5(login.password))) {
          answer['error_message'] = '';
          answer['status'] = true;

          return answer;
        } else if (userList[i].phone == login.phone &&
            (userList[i].password !=
                EncryptHelper.generateMd5(login.password))) {
          answer['status'] = false;
          answer['error_message'] = ServerErrors.passwordError;

          return answer;
        }
      }

      answer['status'] = false;
      answer['error_message'] = ServerErrors.phoneError;
    }

    return answer;
  }
}
