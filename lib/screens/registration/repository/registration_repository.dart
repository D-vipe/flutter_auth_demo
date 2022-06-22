import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/screens/registration/api/registration_api.dart';

class RegistrationRepository {
  Future<Map<String, dynamic>> regUser({required Login regData}) async {
    return await RegistrationApi().registration(regData: regData);
  }
}
