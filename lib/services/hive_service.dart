// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

// Project imports:
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';

class HiveService {
  static late Box users;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LoginAdapter());

    users = await Hive.openBox<Login>('users');
  }

  static List<Login> getUsers() {
    return users.values.toList() as List<Login>;
  }

  static void addUser(Login data) {
    int id = 1;
    if (users.isNotEmpty) {
      id = users.length + 1;
    }
    users.put(id, data);
  }
}
