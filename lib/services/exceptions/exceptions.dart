import 'package:flutter_demo_auth/services/exceptions/common_error_model.dart';

class LoginException implements Exception {
  final CommonError error;

  LoginException(this.error);
}

class BadRequestException implements Exception {
  BadRequestException();
}

class NetworkForbiddenException implements Exception {
  NetworkForbiddenException({
    CommonError? error,
  });
}

class NetworkOtherException implements Exception {
  final String code;

  NetworkOtherException(this.code);
}

class ConnectionException implements Exception {}

class NotFoundException implements Exception {}
