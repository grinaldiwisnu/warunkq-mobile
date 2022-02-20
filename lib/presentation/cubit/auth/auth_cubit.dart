import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/models/register.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.userUC,
  }) : super(AuthInitial());

  final UserUC userUC;

  void auth(String email, String password) async {
    emit(AuthInitial());
    DataState data = await userUC.login(email, password);
    print(data.error);
    if (data.error != null) {
      emit(AuthFailedState(message: data.error!));
    } else {
      emit(AuthSuccessState());
    }
  }

  void register(Register register) async {
    emit(AuthInitial());
    DataState data = await userUC.register(register);
    print(data.error);
    if (data.error != null) {
      emit(RegisterFailedState(message: data.error!));
    } else {
      emit(RegisterSuccessState());
    }
  }
}
