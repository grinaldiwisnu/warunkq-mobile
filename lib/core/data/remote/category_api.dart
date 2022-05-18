import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class CategoryAPI implements CategoryRemote {
  Future<ApiResponse<List<Category>>> find() async {
    try {
      Response res = await App().dio.get(UrlHelper.category);
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Category>>(
            result: List.generate(
                res.data['result']['data'].length,
                (index) =>
                    Category.fromJson(res.data['result']['data'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Category>>> create(Category data) async {
    try {
      Response res =
          await App().dio.post(UrlHelper.category, data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Category>>(
            result: List.generate(res.data['result'].length,
                (index) => Category.fromJson(res.data['result'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Category>>> save(Category data) async {
    try {
      Response res = await App()
          .dio
          .put(UrlHelper.category + "${data.id}", data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Category>>(
            result: List.generate(res.data['result'].length,
                (index) => Category.fromJson(res.data['result'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  @override
  Future<ApiResponse> delete(Category data) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
