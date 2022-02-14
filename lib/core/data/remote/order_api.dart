import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class OrderAPI implements API {
  @override
  Future<ApiResponse<List<Transaction>>> findAll(dates) async {
    try {
      Response res = await App().dio.get(UrlHelper.order,
          queryParameters: {"startdate": dates.first, "enddate": dates.last});
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Transaction>>(
            result: List.generate(
                res.data['result']['data'].length,
                (index) =>
                    Transaction.fromJson(res.data['result']['data'][index])),
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
  Future<ApiResponse> create(data) async {
    try {
      Response res =
          await App().dio.post(UrlHelper.order, data: data!.toJson());
      print(res.data);
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse(
            result: res.data['result'], status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  @override
  Future<ApiResponse<List<Transaction>>> find(orderNumber) async {
    try {
      Response res =
          await App().dio.get("${UrlHelper.order}/${orderNumber.toString()}");
      print(res.data);
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Transaction>>(
            result: List.generate(res.data['result'].length,
                (index) => Transaction.fromJson(res.data['result'][index])),
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
  Future<ApiResponse<List<Transaction>>> delete(dynamic) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<List<Transaction>>> save(dynamic) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
