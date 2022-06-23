part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.phoneNumber = const PhoneNumber.pure(),
      this.password = const Password.pure(),
      this.errorMessage = ''});

  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final Password password;
  final String errorMessage;

  LoginState copyWith({
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    Password? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get loginSuccess {
    return status == FormzStatus.submissionSuccess &&
        phoneNumber != const PhoneNumber.pure() &&
        password != const Password.dirty();
  }

  @override
  List<Object> get props => [status, phoneNumber, password];
}
