import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/customer.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit({required this.customerUC}) : super(CustomerInitial());

  // Define Usecase
  final CustomerUC customerUC;

  List<Customer> listCustomer = <Customer>[];
  List<Customer> originListCustomer = <Customer>[];

  void load() async {
    emit(CustomerInitial());
    this.listCustomer.clear();
    this.originListCustomer.clear();
    emit(CustomerLoading());
    DataState<List<Customer>> result = await customerUC.get();
    if (result.error != null) {
      emit(LoadCustomerFailed());
      return;
    }

    this.listCustomer = result.success!;
    this.originListCustomer = result.success!;
    emit(LoadCustomerSuccess());
  }

  void save(Customer data) async {
    emit(CustomerInitial());
    DataState<List<Customer>> result = await customerUC.update(data);
    if (result.error != null) {
      emit(UpdateCustomerFailed());
    } else {
      emit(UpdateCustomerSuccess());
    }
  }

  void add(Customer data) async {
    emit(CustomerInitial());
    DataState<List<Customer>> result = await customerUC.store(data);
    if (result.error != null) {
      emit(AddCustomerFailed());
    } else {
      emit(AddCustomerSuccess());
    }
  }

  void search(String query) async {
    emit(CustomerInitial());
    this.listCustomer = this
        .originListCustomer
        .where((element) =>
            element.name!.toLowerCase().contains(query.toLowerCase()) ||
            element.phone!.contains(query))
        .toList();
    emit(CustomerSearchSuccess());
  }
}
