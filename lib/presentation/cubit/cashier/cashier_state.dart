part of 'cashier_cubit.dart';

abstract class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object> get props => [];
}

class CashierInitial extends CashierState {}

class AddItemSuccess extends CashierState {}

class CashierDeleteOrder extends CashierState {}

class CashierCreateOrderLoading extends CashierState {}

class CashierCreateOrderFailed extends CashierState {}

class CashierCreateOrderSuccess extends CashierState {
  final CartCashier? data;

  CashierCreateOrderSuccess({this.data});
}

class CashierItemDeleted extends CashierState {}

class CashierSendReceiptLoading extends CashierState {}

class CashierSendReceiptSuccess extends CashierState {}

class CashierSendReceiptFailed extends CashierState {}

class CashierUseCustomerSuccess extends CashierState {}
