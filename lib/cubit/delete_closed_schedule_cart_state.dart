part of 'delete_closed_schedule_cart_cubit.dart';

abstract class DeleteClosedScheduleCartState extends Equatable {
  const DeleteClosedScheduleCartState();

  @override
  List<Object> get props => [];
}

class DeleteClosedScheduleCartInitial extends DeleteClosedScheduleCartState {}

class DeleteClosedScheduleCartLoading extends DeleteClosedScheduleCartState {}

class DeleteClosedScheduleCartSuccess extends DeleteClosedScheduleCartState {
  final DefaultResponseModel response;

  const DeleteClosedScheduleCartSuccess(this.response);
}

class DeleteClosedScheduleCartFailed extends DeleteClosedScheduleCartState {
  final String message;

  const DeleteClosedScheduleCartFailed(this.message);
}
