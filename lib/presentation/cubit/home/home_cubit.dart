import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warunkq_apps/core/data/remote/user_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  User user = User();
  UserAPI _userAPI = UserAPI();

  void init() async {
    emit(HomeInitial());
    ApiResponse<User> response = await _userAPI.getUserDetail();
    if (response.status != 200) {
      emit(ErrorPersonalData());
    } else {
      user = response.result!;
      emit(SuccessPersonalData());
    }
  }
}
