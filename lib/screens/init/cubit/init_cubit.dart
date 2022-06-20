import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_demo_auth/services/shared_preferences.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitInitial()) {
    initializeCubit();
  }

  Future<void> initializeCubit() async {
    var isLoggedIn = SharedStorageService.getBool(PreferenceKey.isLoggedIn);
    if (isLoggedIn) {
      emit(LoggedIn());
    } else {
      emit(NeedToLogin());
    }
  }
}
