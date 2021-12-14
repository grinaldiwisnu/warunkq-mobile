import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecases/category_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  // Define Usecase
  CategoryUsecase categoryUsecase = CategoryUsecase();

  List<Category> listCaategory = List<Category>();

  void load() async {
    emit(CategoryInitial());
    DataState<List<Category>> result = await categoryUsecase.get();
    if (result.error != null) {
      emit(LoadCategoryFailed());
      return;
    }

    this.listCaategory = result.success;
    emit(LoadCategorySuccess());
  }
}
