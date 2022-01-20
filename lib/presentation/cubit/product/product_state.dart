part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class LoadProductFailed extends ProductState {}

class LoadProductSuccess extends ProductState {}

class UpdateProductFailed extends ProductState {}

class UpdateProductSuccess extends ProductState {}

class AddProductFailed extends ProductState {}

class AddProductSuccess extends ProductState {}
