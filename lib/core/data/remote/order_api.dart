import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/linear_sales.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class OrderAPI implements OrderRemote {
  @override
  Future<ApiResponse<List<Transaction>>> findAll(List<DateTime> dates) async {
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
  Future<ApiResponse> create(CartCashier data) async {
    try {
      Response res =
          await App().dio.post(UrlHelper.order, data: data.toJson());
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
  Future<ApiResponse<List<Transaction>>> find(String orderNumber) async {
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

  Future<ApiResponse<ChartSummary>> summary(List<DateTime> dates) async {
    try {
      Response res = await App().dio.get(UrlHelper.order + "/report/summary",
          queryParameters: {"start_date": dates.first, "end_date": dates.last});
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<ChartSummary>(
            result: ChartSummary(
              data: List.generate(
                  res.data['result']['data'].length,
                      (index) =>
                      LinearSales.fromJson(res.data['result']['data'][index])),
              summary: Summary.fromJson(res.data['result']['summary'][0]),
            ),
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
  Future<ApiResponse<List<TopSelling>>> topSelling(List<DateTime> dates) async {
    try {
      Response res = await App().dio.get(UrlHelper.order + "/report/selling",
          queryParameters: {"start_date": dates.first, "end_date": dates.last});
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<TopSelling>>(
            result: List.generate(
                res.data['result'].length,
                    (index) =>
                        TopSelling.fromJson(res.data['result'][index])),
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
