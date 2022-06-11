import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productUC}) : super(ProductInitial());

  // Define Usecase
  final ProductUC productUC;

  List<Product> listProduct = <Product>[];
  List<Product> originListProduct = <Product>[];

  void load() async {
    emit(ProductInitial());
    this.listProduct.clear();
    this.originListProduct.clear();
    emit(ProductLoading());
    DataState<List<Product>> result = await productUC.get();
    if (result.error != null) {
      emit(LoadProductFailed());
      return;
    }

    this.listProduct = result.success!;
    this.originListProduct = result.success!;
    emit(LoadProductSuccess());
  }

  void save(Product data) async {
    emit(ProductLoading());
    DataState<List<Product>> result = await productUC.update(data);
    if (result.error != null) {
      emit(UpdateProductFailed());
    } else {
      emit(UpdateProductSuccess());
    }
  }

  void add(Product data) async {
    emit(ProductLoading());
    DataState<List<Product>> result = await productUC.store(data);
    if (result.error != null) {
      emit(AddProductFailed());
    } else {
      emit(AddProductSuccess());
    }
  }

  void search(String query) async {
    emit(ProductLoading());
    this.listProduct = this
        .originListProduct
        .where((element) =>
            element.productName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(ProductSearchSuccess());
  }
}
