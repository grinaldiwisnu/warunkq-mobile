import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/detail_order.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/core/usecases/order_usecase.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit() : super(CashierInitial());

  OrderUC orderUC = OrderUsecase();

  CartCashier cartCashier = CartCashier();

  void addItem(Product product) async {
    emit(CashierInitial());
    if (cartCashier.detailOrder.length == 0) {
      cartCashier.orderNumber = "WQ-" + _generateOrderNumber();
      cartCashier.orderName = "CUST-" + _generateOrderNumber();
    }

    DetailOrder? detailOrder;
    int found = 0;
    for (int i = 0; i < cartCashier.detailOrder.length; i++) {
      if (cartCashier.detailOrder[i].prodId == product.id) {
        detailOrder = cartCashier.detailOrder[i];
        found = i;
      }
    }

    if (GlobalHelper.isEmpty(detailOrder)) {
      detailOrder = DetailOrder(
        product: product,
        prodId: product.id,
        quantity: 1,
        subTotal: product.price!,
      );
      cartCashier.detailOrder.add(detailOrder);
    } else {
      cartCashier.detailOrder[found].quantity++;
      cartCashier.detailOrder[found].subTotal += product.price!;
      cartCashier.detailOrder[found].productionPrice = product.basePrice!;
    }

    cartCashier.totalPrice += product.price!;
    cartCashier.totalProduct++;

    emit(AddItemSuccess());
  }

  void deleteOrder() async {
    emit(CashierInitial());
    cartCashier.detailOrder.clear();
    cartCashier.totalPrice = 0;
    cartCashier.totalProduct = 0;

    emit(CashierDeleteOrder());
  }

  void deleteItem(DetailOrder item) async {
    emit(CashierInitial());
    cartCashier.detailOrder.remove(item);
    cartCashier.totalPrice -= item.subTotal;
    cartCashier.totalProduct -= item.quantity;
    emit(CashierItemDeleted());
  }

  String _generateOrderNumber() {
    DateTime dateNow = DateTime.now();
    String day, month;
    // Generate Year Code
    String year = dateNow.year.toString().substring(2, 4);
    // Generate Month Code
    if (dateNow.month.toString().length == 1) {
      month = "0" + dateNow.month.toString();
    } else {
      month = dateNow.month.toString();
    }
    // Generate Day Code
    if (dateNow.day.toString().length == 1) {
      day = "0" + dateNow.day.toString();
    } else {
      day = dateNow.day.toString();
    }

    String orderNumber = year + month + day + _getRandomNumber();

    return orderNumber;
  }

  String _getRandomNumber() {
    final r = Random();
    return List<int>.generate(6, (index) => r.nextInt(10))
        .fold<String>("", (prev, i) => prev += i.toString());
  }

  void createOrder() async {
    emit(CashierCreateOrderLoading());

    cartCashier.usersId = App().prefs.getInt(ConstantHelper.PREFS_USER_ID);
    cartCashier.status = "success";

    print(this.cartCashier.toJson());
    final tempResult = cartCashier;
    DataState result = await orderUC.store(this.cartCashier);
    if (!GlobalHelper.isEmpty(result.error)) {
      emit(CashierCreateOrderFailed());
    } else {
      cartCashier = CartCashier();
      emit(CashierCreateOrderSuccess(data: tempResult));
    }
  }
}
