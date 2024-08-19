import 'package:dio/dio.dart';
import 'package:test_api_app/cache/cache_helper.dart';
import 'package:test_api_app/core/api/end_points.dart';

class ApiInterceptors extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.token] = CacheHelper().getData(key: ApiKey.token) != null ?'FOODAPI ${CacheHelper().getData(key: ApiKey.token)}': null;
    super.onRequest(options, handler);
  }
}