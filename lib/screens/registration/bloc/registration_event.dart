part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends RegistrationEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends RegistrationEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RepeatPasswordChanged extends RegistrationEvent {
  const RepeatPasswordChanged(this.passwordRepeat);

  final String passwordRepeat;

  @override
  List<Object> get props => [passwordRepeat];
}

class RegisterSubmitted extends RegistrationEvent {
  final String phone;
  final String password;
  final String passwordRepeat;

  const RegisterSubmitted(
      {required this.phone,
      required this.password,
      required this.passwordRepeat});
}

class RestoreSubmitted extends RegistrationEvent {
  const RestoreSubmitted();
}
