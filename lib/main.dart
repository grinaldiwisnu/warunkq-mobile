import 'package:flutter/material.dart';
import 'package:warunkq_apps/app.dart';
import 'injection_container.dart' as di;
import 'package:warunkq_apps/presentation/views/entrypoint.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  App.configure(apiBaseURL: "https://multazamgsd.com/warunkq-api/", appTitle: 'WarunkQ');

  await di.init();

  await App().init();

  runApp(Entrypoint());
}
