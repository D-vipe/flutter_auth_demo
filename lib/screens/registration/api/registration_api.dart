import 'dart:convert';
import 'dart:io';

import 'package:flutter_demo_auth/app/constants/app_dictionary.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/services/encryption.dart';

class RegistrationApi {
  final File file = File('./assets/user.json');

  Future<Map<String, dynamic>> registration({required Login regData}) async {
    Map<String, dynamic> answer = {'status': false, 'error_message': ''};

    // First get data from file
    final String fileData = await _readFile();
    List<Map<String, String>> usersList = [];

    if (fileData == '') {
      usersList.add({
        'phone': regData.phone,
        'password': EncryptHelper.generateMd5(regData.password)
      });
      answer['status'] = true;
    } else {
      usersList = jsonDecode(fileData);

      for (var el in usersList) {
        if (el['phone'] == regData.phone) {
          answer['error_message'] = AppDictionary.errorUserExists;
        } else {
          usersList.add({
            'phone': regData.phone,
            'password': EncryptHelper.generateMd5(regData.password)
          });
          answer['status'] = true;
        }
      }
    }

    return answer;
  }

  Future<String> _readFile() async {
    return await file.readAsString();
  }

  Future<File> _writeFile({required String contents}) {
    return file.writeAsString(contents);
  }
}
