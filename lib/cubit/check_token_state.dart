part of 'check_token_cubit.dart';

abstract class CheckTokenState extends Equatable {
  const CheckTokenState();

  @override
  List<Object> get props => [];
}

class CheckTokenInitial extends CheckTokenState {}

class CheckTokenLoading extends CheckTokenState {}

class CheckTokenSuccess extends CheckTokenState {
  final DefaultResponseModel response;

  const CheckTokenSuccess(this.response);
}

class CheckTokenFailed extends CheckTokenState {
  final String message;

  const CheckTokenFailed(this.message);
}
