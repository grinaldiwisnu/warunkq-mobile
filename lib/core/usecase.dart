import 'package:warunkq_apps/core/resources/state.dart';

abstract class UseCase {
  Future<DataState> get();
  Future<DataState> store(dynamic data);
  Future<DataState> delete();
  Future<DataState> update(dynamic data);
}
