import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/resources/state.dart';

abstract class UseCase {
  SharedPreferences prefs;

  Future<DataState> get();

  Future<DataState> store(dynamic data);

  Future<DataState> delete();

  Future<DataState> update(dynamic data);
}
