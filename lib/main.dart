import 'package:flutter/material.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/entrypoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(apiBaseURL: "http://116.193.190.14:3000/", appTitle: 'WarunkQ');

  await App().init();

  runApp(Entrypoint());
}
