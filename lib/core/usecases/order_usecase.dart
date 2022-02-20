import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/data/remote/order_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/linear_sales.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class OrderUsecase implements OrderUC {
  OrderData _orderData = OrderAPI();
  SharedPreferences? prefs = App().prefs;

  @override
  Future<DataState<List<Transaction>>> get(
      {List<DateTime>? dates, String? orderNumber}) async {
    ApiResponse<List<Transaction>> transaction;
    if (GlobalHelper.isEmpty(orderNumber)) {
      transaction = await _orderData.findAll(dates!);
    } else {
      transaction = await _orderData.find(orderNumber!);
    }

    if (transaction.message != null) {
      return DataFailed(transaction.message);
    }
    return DataSuccess(transaction.result);
  }

  @override
  Future<DataState> store(CartCashier data) async {
    ApiResponse categoryData = await _orderData.create(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<ChartSummary>> summary(List<DateTime> dates) async {
    ApiResponse categoryData = await _orderData.summary(dates);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<TopSelling>>> topSelling(List<DateTime> dates) async {
    ApiResponse categoryData = await _orderData.topSelling(dates);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }
}
