part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangePassIcon extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSucessState extends AuthState {
  final UserModel model;

  LoginSucessState(this.model);
}

class LoginErrorState extends AuthState {
  final String? error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthState {}

class RegisterSucessState extends AuthState {
  final UserModel model;

  RegisterSucessState(this.model);
}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}
