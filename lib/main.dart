import 'package:flutter/material.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/presentation/views/entrypoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(apiBaseURL: "https://multazamgsd.com/warunkq-api/", appTitle: 'WarunkQ');

  await App().init();

  runApp(Entrypoint());
}
