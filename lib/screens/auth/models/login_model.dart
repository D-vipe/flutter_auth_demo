// Package imports:
import 'package:hive/hive.dart';

part 'login_model.g.dart';

@HiveType(typeId: 1)
class Login extends HiveObject {
  @HiveField(0)
  final String phone;
  @HiveField(1)
  final String password;

  Login({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
