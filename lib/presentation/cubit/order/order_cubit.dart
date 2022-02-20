import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderUC}) : super(OrderInitial());

  final OrderUC orderUC;

  List<Transaction> _originOrders = <Transaction>[];
  List<Transaction> listOrder = <Transaction>[];

  void load({DateTime? startDate, DateTime? endDate}) async {
    emit(OrderInitial());
    this.listOrder.clear();
    emit(OrderLoading());
    DataState<List<Transaction>> result = await orderUC.get(
      dates: [startDate!, endDate!]
    );
    if (result.error != null) {
      emit(LoadOrderFailed());
    } else {
      this._originOrders = result.success!;
      this.listOrder = result.success!;
      emit(LoadOrderSuccess());
    }
  }

  void search(String value) async {
    emit(OrderInitial());
    if (value.length >= 3) {
      var find = (obj) => obj.orderName == value;
      this.listOrder = this._originOrders.where(find).toList();
      if (this.listOrder.length == 0)
        emit(SearchOrderFailed());
      else
        emit(SearchOrderSuccess());
    } else if (value.length < 3) {
      this.listOrder = this._originOrders;
      emit(SearchOrderSuccess());
    }
  }

  void prepareDetail(Transaction data) async {
    emit(OrderInitial());
    DataState<List<Transaction>> result = await orderUC.get(orderNumber: data.orderId);
    if (result.error != null) {
      emit(DetailOrderFailed());
    } else {
      emit(DetailOrderSuccess(data: result.success!.first));
    }
  }
}
