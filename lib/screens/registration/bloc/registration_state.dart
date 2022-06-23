part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.status = FormzStatus.pure,
      this.phoneNumber = const PhoneNumber.pure(),
      this.password = const Password.pure(),
      this.passwordRepeat = const Password.pure(),
      this.errorMessage = ''});

  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final Password password;
  final Password passwordRepeat;
  final String errorMessage;

  RegistrationState copyWith({
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    Password? password,
    Password? passwordRepeat,
    String? errorMessage,
  }) {
    return RegistrationState(
        status: status ?? this.status,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        passwordRepeat: passwordRepeat ?? this.passwordRepeat,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  bool get registerSuccess {
    return status == FormzStatus.submissionSuccess &&
        phoneNumber != const PhoneNumber.pure();
  }

  @override
  List<Object> get props => [status, phoneNumber, password, passwordRepeat];
}
