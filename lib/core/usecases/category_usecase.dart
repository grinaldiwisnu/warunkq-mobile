import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/data/remote/category_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';

class CategoryUsecase implements CategoryUC {
  SharedPreferences? prefs = App().prefs;

  CategoryData _categoryData = CategoryAPI();

  @override
  Future<DataState<List<Category>>> get() async {
    ApiResponse<List<Category>> categoryData = await _categoryData.find();
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> store(Category data) async {
    ApiResponse<List<Category>> categoryData = await _categoryData.create(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> update(Category data) async {
    ApiResponse<List<Category>> categoryData = await _categoryData.save(data);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }
}
