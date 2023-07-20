part of 'request_new_password_cubit.dart';

abstract class RequestNewPasswordState extends Equatable {
  const RequestNewPasswordState();

  @override
  List<Object> get props => [];
}

class RequestNewPasswordInitial extends RequestNewPasswordState {}

class RequestNewPasswordLoading extends RequestNewPasswordState {}

class RequestNewPasswordSuccess extends RequestNewPasswordState {
  final DefaultResponseModel response;

  const RequestNewPasswordSuccess(this.response);
}

class RequestNewPasswordFailed extends RequestNewPasswordState {
  final String message;

  const RequestNewPasswordFailed(this.message);
}
