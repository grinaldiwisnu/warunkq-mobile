import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/product.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit() : super(CashierInitial());

  CartCashier cartCashier = CartCashier();

  void addItem(Product product) async {
    emit(CashierInitial());

    DetailOrder data =
        DetailOrder(prodId: product.id, quantity: 1, subTotal: product.price);
    cartCashier.detailOrder.add(data);
    cartCashier.totalPrice += product.price;

    emit(AddItemSuccess());
  }
}
