import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/order_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class OrderUsecase implements UseCase {
  OrderAPI orderAPI = OrderAPI();
  SharedPreferences? prefs = App().prefs;

  @override
  Future<DataState> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<Transaction>>> get(
      {List<DateTime>? dates, String? orderNumber}) async {
    ApiResponse<List<Transaction>> transaction;
    if (GlobalHelper.isEmpty(orderNumber)) {
      transaction = await orderAPI.findAll(dates);
    } else {
      transaction = await orderAPI.find(orderNumber);
    }

    if (transaction.message != null) {
      return DataFailed(transaction.message);
    }
    return DataSuccess(transaction.result);
  }

  @override
  Future<DataState> store(data) async {
    ApiResponse categoryData = await orderAPI.create(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
