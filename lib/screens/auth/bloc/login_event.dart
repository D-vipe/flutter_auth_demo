part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPhoneNumberChanged extends LoginEvent {
  const LoginPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String password;
  final String phoneNumber;

  const LoginSubmitted({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props => [phoneNumber, password];
}
