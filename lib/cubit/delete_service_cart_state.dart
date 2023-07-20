part of 'delete_service_cart_cubit.dart';

abstract class DeleteServiceCartState extends Equatable {
  const DeleteServiceCartState();

  @override
  List<Object> get props => [];
}

class DeleteServiceCartInitial extends DeleteServiceCartState {}

class DeleteServiceCartLoading extends DeleteServiceCartState {}

class DeleteServiceCartSuccess extends DeleteServiceCartState {
  final DefaultResponseModel response;

  const DeleteServiceCartSuccess(this.response);
}

class DeleteServiceCartFailed extends DeleteServiceCartState {
  final String message;

  const DeleteServiceCartFailed(this.message);
}
