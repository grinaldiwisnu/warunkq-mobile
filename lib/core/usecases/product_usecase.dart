import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/product_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';

class ProductUsecase {
  ProductAPI _productAPI = ProductAPI();
  SharedPreferences prefs = App().prefs;

  Future<DataState<List<Product>>> get() async {
    ApiResponse<List<Product>> userData = await _productAPI.getAllProduct();
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }
}
