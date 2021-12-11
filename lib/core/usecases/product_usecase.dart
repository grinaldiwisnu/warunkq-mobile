import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/product_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

class ProductUsecase implements UseCase {
  ProductAPI _productAPI = ProductAPI();

  @override
  Future<DataState<List<Product>>> get() async {
    ApiResponse<List<Product>> userData = await _productAPI.findAll();
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }

  @override
  SharedPreferences prefs = App().prefs;

  @override
  Future<DataState> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DataState> store(data) async {
    ApiResponse<List<Product>> userData = await _productAPI.create(data);
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }

  @override
  Future<DataState> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
