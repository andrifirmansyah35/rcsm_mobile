part of 'add_service_cart_cubit.dart';

abstract class AddServiceCartState extends Equatable {
  const AddServiceCartState();

  @override
  List<Object> get props => [];
}

class AddServiceCartInitial extends AddServiceCartState {}

class AddServiceCartLoading extends AddServiceCartState {}

class AddServiceCartSuccess extends AddServiceCartState {
  final AlertSuccessModel response;

  const AddServiceCartSuccess(this.response);
}

class AddServiceCartFailed extends AddServiceCartState {
  final String message;

  const AddServiceCartFailed(this.message);
}
