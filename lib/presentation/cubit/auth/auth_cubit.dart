import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecases/user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserUsecase uc = UserUsecase();

  void auth(String email, String password) async {
    emit(AuthInitial());
    DataState data = await uc.login(email, password);
    print(data.error);
    if (data.error != null) {
      emit(AuthFailedState(message: data.error));
    } else {
      emit(AuthSuccessState());
    }
  }

  void register(String email, String password) async {
    emit(AuthInitial());
    DataState data = await uc.login(email, password);
    print(data.error);
    if (data.error != null) {
      emit(RegisterFailedState(message: data.error));
    } else {
      emit(RegisterSuccessState());
    }
  }
}
