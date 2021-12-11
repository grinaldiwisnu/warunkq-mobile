import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/category_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';

class CategoryUsecase implements UseCase {
  @override
  SharedPreferences prefs = App().prefs;

  CategoryAPI _categoryAPI = CategoryAPI();

  @override
  Future<DataState> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<Category>>> get() async {
    ApiResponse<List<Category>> userData = await _categoryAPI.findAll();
    if (userData.message != null) {
      return DataFailed(userData.message);
    }
    return DataSuccess(userData.result);
  }

  @override
  Future<DataState> store(data) async {
    ApiResponse<List<Category>> userData = await _categoryAPI.create(data);
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
