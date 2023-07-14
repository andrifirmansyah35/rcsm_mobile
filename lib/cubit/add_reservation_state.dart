part of 'add_reservation_cubit.dart';

abstract class AddReservationState extends Equatable {
  const AddReservationState();

  @override
  List<Object> get props => [];
}

class AddReservationInitial extends AddReservationState {}

class AddReservationLoading extends AddReservationState {}

class AddReservationSuccess extends AddReservationState {
  final DefaultResponseModel response;

  const AddReservationSuccess(this.response);
}

class AddReservationFailed extends AddReservationState {
  final String message;

  const AddReservationFailed(this.message);
}
