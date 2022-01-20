import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/helpers/url_helper.dart';

class ProductAPI {
  Future<ApiResponse<List<Product>>> findAll() async {
    try {
      Response res = await App().dio.get(UrlHelper.product);
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Product>>(
            result: List.generate(res.data['result']['data'].length,
                (index) => Product.fromJson(res.data['result']['data'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Product>>> create(Product data) async {
    try {
      Response res =
          await App().dio.post(UrlHelper.product, data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Product>>(
            result: List.generate(res.data['result'].length,
                (index) => Product.fromJson(res.data['result'][index])),
            status: res.data['status']);
      }

      return ApiResponse(
          status: res.data['status'], message: res.data['message']);
    } catch (e) {
      return ApiResponse(
          status: 500, message: "Something wrong, back in a minutes.");
    }
  }

  Future<ApiResponse<List<Product>>> update(Product data) async {
    try {
      Response res = await App()
          .dio
          .put("${UrlHelper.product}/${data.id}", data: data.toJson());
      if (res.data['status'] == HttpStatus.ok) {
        return ApiResponse<List<Product>>(
            result: List.generate(res.data['result'].length,
                (index) => Product.fromJson(res.data['result'][index])),
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
