import 'package:warunkq_apps/core/models/api_response.dart';

abstract class API {
  Future<ApiResponse> findAll(data);
  Future<ApiResponse> find(data);
  Future<ApiResponse> create(data);
  Future<ApiResponse> save(data);
  Future<ApiResponse> delete(data);
}
