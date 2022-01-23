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

  List<Category> listCategory = <Category>[];

  void load() async {
    emit(CategoryLoading());
    DataState<List<Category>> result = await categoryUsecase.get();
    if (result.error != null) {
      emit(LoadCategoryFailed());
    } else {
      this.listCategory = result.success!;
      emit(LoadCategorySuccess());
    }
  }

  void save(Category data) async {
    emit(CategoryLoading());
    DataState<List<Category>> result = await categoryUsecase.update(data);
    if (result.error != null) {
      emit(UpdateCategoryFailed());
    } else {
      emit(UpdateCategorySuccess());
    }
  }

  void add(Category data) async {
    emit(CategoryLoading());
    DataState<List<Category>> result = await categoryUsecase.store(data);
    if (result.error != null) {
      emit(AddCategoryFailed());
    } else {
      emit(AddCategorySuccess());
    }
  }
}
