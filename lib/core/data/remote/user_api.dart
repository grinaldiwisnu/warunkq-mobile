import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/user.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class UserAPI {
  Future<ApiResponse<User>> login(String email, String password) async {
    try {
      Response res = await App()
          .dio
          .post(UrlHelper.auth, data: {"email": email, "password": password});
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<User>(
            result: User.fromJson(res.data['result']),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<User>> getUserDetail() async {
    try {
      Response res = await App().dio.get(
          UrlHelper.user + App().prefs.getInt(ConstantHelper.PREFS_USER_ID).toString());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<User>(
            result: User.fromJson(res.data['result'].first),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }
}
