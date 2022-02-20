import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/data/remote/product_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

class ProductUsecase implements ProductUC {
  ProductData _productData = ProductAPI();

  @override
  Future<DataState<List<Product>>> get() async {
    ApiResponse<List<Product>> userData = await _productData.find();
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }

  SharedPreferences? prefs = App().prefs;

  @override
  Future<DataState<List<Product>>> store(data) async {
    ApiResponse<List<Product>> productData = await _productData.create(data);
    if (productData.message != null) {
      return DataFailed(productData.message);
    }
    return DataSuccess(productData.result);
  }

  @override
  Future<DataState<List<Product>>> update(data) async {
    ApiResponse<List<Product>> productData = await _productData.save(data);
    print(productData.result.toString());
    if (productData.message != null) {
      return DataFailed(productData.message);
    }
    return DataSuccess(productData.result);
  }
}
