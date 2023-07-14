part of 'schedule_check_cubit.dart';

abstract class ScheduleCheckState extends Equatable {
  const ScheduleCheckState();

  @override
  List<Object> get props => [];
}

class ScheduleCheckInitial extends ScheduleCheckState {}

class ScheduleCheckLoading extends ScheduleCheckState {}

class ScheduleCheckSuccess extends ScheduleCheckState {
  final List<OperasionalModel> response;

  const ScheduleCheckSuccess(this.response);
}

class ScheduleCheckFailed extends ScheduleCheckState {
  final String message;

  const ScheduleCheckFailed(this.message);
}
