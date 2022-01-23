import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecases/product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  // Define Usecase
  ProductUsecase productUsecase = ProductUsecase();

  List<Product> listProduct = <Product>[];

  void load() async {
    emit(ProductInitial());
    this.listProduct.clear();
    emit(ProductLoading());
    DataState<List<Product>> result = await productUsecase.get();
    if (result.error != null) {
      emit(LoadProductFailed());
      return;
    }

    this.listProduct = result.success!;
    emit(LoadProductSuccess());
  }

  void save(Product data) async {
    emit(ProductLoading());
    DataState<List<Product>> result = await productUsecase.update(data);
    if (result.error != null) {
      emit(UpdateProductFailed());
    } else {
      emit(UpdateProductSuccess());
    }
  }

  void add(Product data) async {
    emit(ProductLoading());
    DataState<List<Product>> result = await productUsecase.store(data);
    if (result.error != null) {
      emit(AddProductFailed());
    } else {
      emit(AddProductSuccess());
    }
  }
}
