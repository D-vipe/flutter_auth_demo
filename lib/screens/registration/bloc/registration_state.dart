part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.status = FormzStatus.pure,
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.passwordRepeat = const Password.pure(),
  });

  final FormzStatus status;
  final PhoneNumber phoneNumber;
  final Password password;
  final Password passwordRepeat;

  RegistrationState copyWith({
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    Password? password,
    Password? passwordRepeat,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  bool get registerSuccess {
    return status == FormzStatus.submissionSuccess &&
        phoneNumber != const PhoneNumber.pure();
  }

  @override
  List<Object> get props => [status, phoneNumber, password, passwordRepeat];
}
