import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/customer.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

class CustomerUsecase implements CustomerUC {
  final SharedPreferences prefs;
  final CustomerRemote data;

  CustomerUsecase(this.prefs, this.data);

  @override
  Future<DataState<List<Customer>>> get() async {
    ApiResponse<List<Customer>> categoryData = await data.find();
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Customer>>> store(Customer params) async {
    ApiResponse<List<Customer>> categoryData = await data.create(params);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Customer>>> update(Customer params) async {
    ApiResponse<List<Customer>> categoryData = await data.save(params);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

}