part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class LoadCategoryFailed extends CategoryState {}

class LoadCategorySuccess extends CategoryState {}
