import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/user_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/user.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';

class UserUsecase {
  UserAPI _userAPI = UserAPI();
  SharedPreferences prefs = App().prefs;

  Future<DataState<User>> login(String email, String password) async {
    ApiResponse<User> userData = await _userAPI.login(email, password);
    if (userData.message != null) {
      return DataFailed(userData.message);
    }

    prefs.setString(ConstantHelper.PREFS_TOKEN_KEY, userData.result.token);
    prefs.setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, true);
    prefs.setString(ConstantHelper.PREFS_USER_EMAIL, userData.result.email);
    prefs.setInt(ConstantHelper.PREFS_USER_ID, userData.result.id);
    prefs.setString(ConstantHelper.PREFS_USER_NAME, userData.result.fullname);

    App().dio.options.headers = {
      'Authorization': 'Bearer ${userData.result.token}'
    };

    return DataSuccess(userData.result);
  }
}
