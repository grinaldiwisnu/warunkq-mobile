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
    ApiResponse<List<Category>> categoryData = await _categoryAPI.findAll();
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> store(data) async {
    ApiResponse<List<Category>> categoryData = await _categoryAPI.create(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> update(data) async {
    ApiResponse<List<Category>> categoryData = await _categoryAPI.update(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }
}
