import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/models/customer.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class CustomerAPI implements CustomerRemote {
  Future<ApiResponse<List<Customer>>> find() async {
    try {
      Response res = await App().dio.get(UrlHelper.customer);
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Customer>>(
            result: List.generate(
                res.data['result']['data'].length,
                (index) =>
                    Customer.fromJson(res.data['result']['data'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Customer>>> create(Customer data) async {
    try {
      Response res =
          await App().dio.post(UrlHelper.customer, data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Customer>>(
            result: List.generate(res.data['result'].length,
                (index) => Customer.fromJson(res.data['result'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Customer>>> save(Customer data) async {
    try {
      Response res = await App()
          .dio
          .put(UrlHelper.customer + "${data.id}", data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Customer>>(
            result: List.generate(res.data['result'].length,
                (index) => Customer.fromJson(res.data['result'][index])),
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
  Future<ApiResponse> delete(Customer data) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
