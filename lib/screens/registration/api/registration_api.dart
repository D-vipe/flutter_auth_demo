// Dart imports:
import 'dart:io';

// Project imports:
import 'package:flutter_demo_auth/app/constants/errors_const.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/services/encryption.dart';
import 'package:flutter_demo_auth/services/hive_service.dart';

class RegistrationApi {
  final File file = File('./assets/user.json');

  Future<Map<String, dynamic>> registration({required Login regData}) async {
    Map<String, dynamic> answer = {'status': false, 'error_message': ''};

    // Получим данные из Hive
    List<Login> userList = HiveService.getUsers();

    if (userList.isEmpty) {
      HiveService.addUser(Login(
          phone: regData.phone,
          password: EncryptHelper.generateMd5(regData.password)));
      answer['status'] = true;
    } else {
      for (var i = 0; i < userList.length; i++) {
        // Пользователь существует, вернем статус ошибки
        if (userList[i].phone == regData.phone) {
          answer['status'] = false;
          answer['error_message'] = ServerErrors.userExists;
        }
      }

      if (answer['error_message'] == '') {
        HiveService.addUser(Login(
            phone: regData.phone,
            password: EncryptHelper.generateMd5(regData.password)));
        answer['status'] = true;
      }
    }

    return answer;
  }
}
