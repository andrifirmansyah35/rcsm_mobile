part of 'service_category_cubit.dart';

abstract class ServiceCategoryState extends Equatable {
  const ServiceCategoryState();

  @override
  List<Object> get props => [];
}

class ServiceCategoryInitial extends ServiceCategoryState {}

class ServiceCategoryLoading extends ServiceCategoryState {}

class ServiceCategorySuccess extends ServiceCategoryState {
  final List<ServiceCategoryModel> response;

  const ServiceCategorySuccess(this.response);
}

class ServiceCategoryFailed extends ServiceCategoryState {
  final String message;

  const ServiceCategoryFailed(this.message);
}
