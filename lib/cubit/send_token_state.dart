part of 'send_token_cubit.dart';

abstract class SendTokenState extends Equatable {
  const SendTokenState();

  @override
  List<Object> get props => [];
}

class SendTokenInitial extends SendTokenState {}

class SendTokenLoading extends SendTokenState {}

class SendTokenSuccess extends SendTokenState {
  final DefaultResponseModel response;

  const SendTokenSuccess(this.response);
}

class SendTokenFailed extends SendTokenState {
  final String message;

  const SendTokenFailed(this.message);
}
