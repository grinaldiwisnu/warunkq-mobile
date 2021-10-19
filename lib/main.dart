import 'package:flutter/material.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/entrypoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(apiBaseURL: "", appTitle: 'WarunkQ');

  await App().init();

  runApp(Entrypoint());
}
