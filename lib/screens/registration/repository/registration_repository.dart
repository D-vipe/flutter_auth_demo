// Project imports:
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/screens/registration/api/registration_api.dart';
import 'package:flutter_demo_auth/services/exceptions/common_error_model.dart';
import 'package:flutter_demo_auth/services/exceptions/exceptions.dart';

class RegistrationRepository {
  Future<Map<String, dynamic>> regUser({required Login regData}) async {
    Map<String, dynamic> res =
        await RegistrationApi().registration(regData: regData);
    if (!res['status']) {
      throw LoginException(
          CommonError(success: false, error: res['error_message']));
    }

    return res;
  }
}
