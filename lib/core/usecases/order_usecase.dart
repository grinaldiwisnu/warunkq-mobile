import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class OrderUsecase implements OrderUC {
  final OrderData data;
  final SharedPreferences prefs;

  OrderUsecase(this.data, this.prefs);

  @override
  Future<DataState<List<Transaction>>> get(
      {List<DateTime>? dates, String? orderNumber}) async {
    ApiResponse<List<Transaction>> transaction;
    if (GlobalHelper.isEmpty(orderNumber)) {
      transaction = await data.findAll(dates!);
    } else {
      transaction = await data.find(orderNumber!);
    }

    if (transaction.message != null) {
      return DataFailed(transaction.message);
    }
    return DataSuccess(transaction.result);
  }

  @override
  Future<DataState> store(CartCashier params) async {
    ApiResponse categoryData = await data.create(params);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<ChartSummary>> summary(List<DateTime> dates) async {
    ApiResponse categoryData = await data.summary(dates);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<TopSelling>>> topSelling(List<DateTime> dates) async {
    ApiResponse categoryData = await data.topSelling(dates);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }
}
