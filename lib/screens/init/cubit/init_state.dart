part of 'init_cubit.dart';

abstract class InitState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitInitial extends InitState {}

class NeedToLogin extends InitState {}

class LoggedIn extends InitState {}
