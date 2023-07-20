part of 'delete_closed_service_cubit.dart';

abstract class DeleteClosedServiceState extends Equatable {
  const DeleteClosedServiceState();

  @override
  List<Object> get props => [];
}

class DeleteClosedServiceInitial extends DeleteClosedServiceState {}

class DeleteClosedServiceLoading extends DeleteClosedServiceState {}

class DeleteClosedServiceSuccess extends DeleteClosedServiceState {
  final DefaultResponseModel response;

  const DeleteClosedServiceSuccess(this.response);
}

class DeleteClosedServiceFailed extends DeleteClosedServiceState {
  final String message;

  const DeleteClosedServiceFailed(this.message);
}
