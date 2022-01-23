part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class LoadOrderFailed extends OrderState {}

class LoadOrderSuccess extends OrderState {}

class SearchOrderFailed extends OrderState {}

class SearchOrderSuccess extends OrderState {}

class DetailOrderSuccess extends OrderState {
  final Transaction? data;

  DetailOrderSuccess({this.data});
}

class DetailOrderFailed extends OrderState {}
