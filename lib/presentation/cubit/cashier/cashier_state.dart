part of 'cashier_cubit.dart';

abstract class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object> get props => [];
}

class CashierInitial extends CashierState {}

class AddItemSuccess extends CashierState {}
