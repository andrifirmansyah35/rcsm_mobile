part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final DefaultResponseModel response;

  const ChangePasswordSuccess(this.response);
}

class ChangePasswordFailed extends ChangePasswordState {
  final String message;

  const ChangePasswordFailed(this.message);
}
