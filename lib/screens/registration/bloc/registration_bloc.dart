import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_auth/screens/auth/models/login_model.dart';
import 'package:flutter_demo_auth/screens/auth/models/models.dart';
import 'package:flutter_demo_auth/screens/registration/repository/registration_repository.dart';
import 'package:formz/formz.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository repository;

  RegistrationBloc({required this.repository})
      : super(const RegistrationState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RepeatPasswordChanged>(_onRepeatPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([phoneNumber]),
    ));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<RegistrationState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.phoneNumber]),
    ));
  }

  void _onRepeatPasswordChanged(
      RepeatPasswordChanged event, Emitter<RegistrationState> emit) {
    final repeatPassword = Password.dirty(event.passwordRepeat);
    emit(state.copyWith(
      password: repeatPassword,
      status: Formz.validate([repeatPassword, state.phoneNumber]),
    ));
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        Map<String, dynamic> answer = await repository.regUser(
            regData: Login(phone: event.phone, password: event.password));

        if (state.phoneNumber == const PhoneNumber.dirty('+7(901)753-10-93')) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          _onPhoneNumberChanged(const PhoneNumberChanged(''), emit);
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
