part of 'delete_schedule_cart_cubit.dart';

abstract class DeleteScheduleCartState extends Equatable {
  const DeleteScheduleCartState();

  @override
  List<Object> get props => [];
}

class DeleteScheduleCartInitial extends DeleteScheduleCartState {}

class DeleteScheduleCartLoading extends DeleteScheduleCartState {}

class DeleteScheduleCartSuccess extends DeleteScheduleCartState {
  final DefaultResponseModel response;

  const DeleteScheduleCartSuccess(this.response);
}

class DeleteScheduleCartFailed extends DeleteScheduleCartState {
  final String message;

  const DeleteScheduleCartFailed(this.message);
}
