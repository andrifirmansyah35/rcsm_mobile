part of 'list_service_cart_cubit.dart';

abstract class ListServiceCartState extends Equatable {
  const ListServiceCartState();

  @override
  List<Object> get props => [];
}

class ListServiceCartInitial extends ListServiceCartState {}

class ListServiceCartLoading extends ListServiceCartState {}

class ListServiceCartSuccess extends ListServiceCartState {
  final ListServiceCartModel response;

  const ListServiceCartSuccess(this.response);
}

class ListServiceCartFailed extends ListServiceCartState {
  final String message;

  const ListServiceCartFailed(this.message);
}
