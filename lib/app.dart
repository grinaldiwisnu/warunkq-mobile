import 'package:dio/dio.dart';
import 'package:flutter_flipperkit/flipper_client.dart';
import 'package:flutter_flipperkit/plugins/network/flipper_network_plugin.dart';
import 'package:flutter_flipperkit/plugins/sharedpreferences/flipper_shared_preferences_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/di.dart';

class App {
  static App? _instance;
  final String? apiBaseURL;
  final String? appTitle;

  late SharedPreferences prefs;
  late Dio dio;

  App.configure({this.apiBaseURL, this.appTitle}) {
    _instance = this;
  }

  factory App() {
    if (_instance == null) {
      throw UnimplementedError("App must be configured first.");
    }

    return _instance!;
  }

  Future<Null> init() async {
    prefs = sl<SharedPreferences>();

    _initDio();

    FlipperClient flipperClient = FlipperClient.getDefault();
    flipperClient.addPlugin(FlipperNetworkPlugin());
    flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
    flipperClient.start();
  }

  void _initDio() {
    dio = Dio(BaseOptions(
      baseUrl: apiBaseURL!,
      connectTimeout: 10000,
      receiveTimeout: 50000,
      responseType: ResponseType.json
    ));

    if (!GlobalHelper.isEmpty(prefs.get(ConstantHelper.PREFS_TOKEN_KEY))) {
      dio.options.headers = {
        'Authorization': 'Bearer ${prefs.get(ConstantHelper.PREFS_TOKEN_KEY)}'
      };
    }

    dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) async {
      //Map<String, dynamic> data = e.response.data;
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 400) {}
        // INFO : Kicking out user to login page when !authenticated
        if (e.response?.statusCode == 401) {
          //String message = data['message'];
        }
      }
      return handler.next(e);
    }));
  }
}
