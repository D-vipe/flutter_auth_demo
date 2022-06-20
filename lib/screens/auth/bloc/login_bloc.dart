// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

// Project imports:
import 'package:flutter_demo_auth/app/constants/errors_const.dart';
import 'package:flutter_demo_auth/screens/auth/login_repository.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/services/exceptions/exceptions.dart';
import '../models/models.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(const LoginState()) {
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([state.password, phoneNumber]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.phoneNumber]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var phone = event.phoneNumber
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '')
            .replaceAll(' ', '');
        await repository
            .userLogin(
                login: Login(
              phone: phone,
              password: event.password,
            ))
            .then((value) =>
                emit(state.copyWith(status: FormzStatus.submissionSuccess)));
      } catch (exception) {
        if (exception is LoginException) {
          if (exception.error.error == ServerErrors.phoneError) {
            _onPhoneNumberChanged(const LoginPhoneNumberChanged(''), emit);
          }
          if (exception.error.error == ServerErrors.passwordError) {
            _onPasswordChanged(const LoginPasswordChanged(''), emit);
          }
        }
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
