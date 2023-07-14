part of 'add_schedule_cart_cubit.dart';

abstract class AddScheduleCartState extends Equatable {
  const AddScheduleCartState();

  @override
  List<Object> get props => [];
}

class AddScheduleCartInitial extends AddScheduleCartState {}

class AddScheduleCartLoading extends AddScheduleCartState {}

class AddScheduleCartSuccess extends AddScheduleCartState {
  final AddScheduleCartModel response;

  const AddScheduleCartSuccess(this.response);
}

class AddScheduleCartFailed extends AddScheduleCartState {
  final String message;

  const AddScheduleCartFailed(this.message);
}
