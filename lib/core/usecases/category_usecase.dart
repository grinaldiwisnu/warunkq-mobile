import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/usecase.dart';

class CategoryUsecase implements CategoryUC {
  final SharedPreferences prefs;
  final CategoryData data;

  CategoryUsecase(this.prefs, this.data);

  @override
  Future<DataState<List<Category>>> get() async {
    ApiResponse<List<Category>> categoryData = await data.find();
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> store(Category params) async {
    ApiResponse<List<Category>> categoryData = await data.create(params);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }

  @override
  Future<DataState<List<Category>>> update(Category params) async {
    ApiResponse<List<Category>> categoryData = await data.save(params);
    if (categoryData.message != null) {
      return DataFailed(categoryData.message);
    }
    return DataSuccess(categoryData.result);
  }
}
