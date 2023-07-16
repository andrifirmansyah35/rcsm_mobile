part of 'list_reservation_cubit.dart';

abstract class ListReservationState extends Equatable {
  const ListReservationState();

  @override
  List<Object> get props => [];
}

class ListReservationInitial extends ListReservationState {}

class ListReservationLoading extends ListReservationState {}

class ListReservationSuccess extends ListReservationState {
  final ListReservationModel response;

  const ListReservationSuccess(this.response);
}

class ListReservationFailed extends ListReservationState {
  final String message;

  const ListReservationFailed(this.message);
}
