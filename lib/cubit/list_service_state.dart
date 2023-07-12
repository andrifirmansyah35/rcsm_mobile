part of 'list_service_cubit.dart';

abstract class ListServiceState extends Equatable {
  const ListServiceState();

  @override
  List<Object> get props => [];
}

class ListServiceInitial extends ListServiceState {}

class ListServiceLoading extends ListServiceState {}

class ListServiceSuccess extends ListServiceState {
  final List<ServiceModel> response;

  const ListServiceSuccess(this.response);
}

class ListServiceFailed extends ListServiceState {
  final String message;

  const ListServiceFailed(this.message);
}
