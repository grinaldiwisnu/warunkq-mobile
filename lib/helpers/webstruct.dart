import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/webstruct.dart';

class WebStruct {
  late Dio _dio;

  init() {
    _dio = Dio(BaseOptions(
        baseUrl: "https://md.fonnte.com/api/",
        connectTimeout: 10000,
        receiveTimeout: 50000,
        responseType: ResponseType.json,
        contentType: "multipart/form-data"
    ));

    _dio.options.headers = {
      'Authorization': "rZJVj1Vofyv2eEXvx8aq"
    };
  }

  Future<Webstruct> send(CartCashier order, String phoneNumber) async {
    Map<String, dynamic> data = {
      "phone": phoneNumber,
      "type": "text",
      "delay": 1,
      "schedule": 0,
      "text": "Terimakasih telah belanja di Anak Moontoon\n"
          "Berikut adalah struk belanja anda\n"
          "https://multazamgsd.com/warunkq-api/receipt/web/${order.orderNumber}\n\n"
          "Kami menggunakan sistem paperless untuk menghemat penggunaan kertas.\n"
          "Terimakasih."
    };

    try {
      Response res = await _dio.post("send_message.php", data: FormData.fromMap(data));
      return Webstruct.fromJson(jsonDecode(res.data));
    } catch (e) {
      return Webstruct();
    }
  }
}
