part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class LoadCustomerFailed extends CustomerState {}

class LoadCustomerSuccess extends CustomerState {}

class UpdateCustomerFailed extends CustomerState {}

class UpdateCustomerSuccess extends CustomerState {}

class AddCustomerFailed extends CustomerState {}

class AddCustomerSuccess extends CustomerState {}

class CustomerSearchSuccess extends CustomerState {}
