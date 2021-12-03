import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit() : super(CashierInitial());
}
