part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class LoadCategoryFailed extends CategoryState {}

class CategoryLoading extends CategoryState {}

class LoadCategorySuccess extends CategoryState {}

class UpdateCategoryFailed extends CategoryState {}

class UpdateCategorySuccess extends CategoryState {}

class AddCategoryFailed extends CategoryState {}

class AddCategorySuccess extends CategoryState {}