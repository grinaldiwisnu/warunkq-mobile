import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

class ProductUsecase implements ProductUC {
  final ProductRemote data;

  ProductUsecase(this.data);

  @override
  Future<DataState<List<Product>>> get() async {
    ApiResponse<List<Product>> userData = await data.find();
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }

  SharedPreferences? prefs = App().prefs;

  @override
  Future<DataState<List<Product>>> store(params) async {
    ApiResponse<List<Product>> productData = await data.create(params);
    if (productData.message != null) {
      return DataFailed(productData.message);
    }
    return DataSuccess(productData.result);
  }

  @override
  Future<DataState<List<Product>>> update(params) async {
    ApiResponse<List<Product>> productData = await data.save(params);
    print(productData.result.toString());
    if (productData.message != null) {
      return DataFailed(productData.message);
    }
    return DataSuccess(productData.result);
  }
}
