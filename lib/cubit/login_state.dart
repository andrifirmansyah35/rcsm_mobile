part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel response;

  LoginSuccess(this.response);
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
}
