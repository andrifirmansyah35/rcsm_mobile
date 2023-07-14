part of 'list_schedule_cart_cubit.dart';

abstract class ListScheduleCartState extends Equatable {
  const ListScheduleCartState();

  @override
  List<Object> get props => [];
}

class ListScheduleCartInitial extends ListScheduleCartState {}

class ListScheduleCartLoading extends ListScheduleCartState {}

class ListScheduleCartSuccess extends ListScheduleCartState {
  final ListScheduleCartModel response;

  const ListScheduleCartSuccess(this.response);
}

class ListScheduleCartFailed extends ListScheduleCartState {
  final String message;

  const ListScheduleCartFailed(this.message);
}
