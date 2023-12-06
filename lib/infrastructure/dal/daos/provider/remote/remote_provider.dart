import 'package:dio/dio.dart';
import '../../../../../utils/path/environment.dart';
import '../interceptor/header_interceptors.dart';

class RemoteProvider {
  static final Dio _dioInstance = Dio();
  static late BaseOptions _baseOptionBulkUrl;
  static late BaseOptions _baseOptionBaseUrl;
  static late BaseOptions _baseOptionBaseUrlLocation;

  static init() {
    _baseOptionBulkUrl = BaseOptions(baseUrl: kBulkUrl);
    _baseOptionBaseUrl = BaseOptions(baseUrl: kBaseUrl);
    _baseOptionBaseUrlLocation = BaseOptions(baseUrl: kApiUrl);

    _dioInstance.interceptors.add(headerInterceptor(logs: false));
  }

  static Future<Response> post(
      {required String path, Object? data, Options? options}) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.post(path, data: data, options: options);
  }

  static Future<Response> put({required String path, Object? data}) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.put(path, data: data);
  }

  static Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      bool? showLogs}) async {
    _dioInstance.options = _baseOptionBaseUrl;
    return await _dioInstance.get(path, queryParameters: queryParameters);
  }

  static Future<Response> getLocation(
      {required String path,
      Map<String, dynamic>? queryParameters,
      bool? showLogs}) async {
    _dioInstance.options = _baseOptionBaseUrlLocation;
    return await _dioInstance.get(path, queryParameters: queryParameters);
  }

  static Future<Response> delete({required String path}) async {
    _dioInstance.options = _baseOptionBaseUrl;
    return await _dioInstance.delete(path);
  }
}
