import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiRepository {
  static String scheme = 'https';
  static String scope = 'api/v1';
  static String host = 'api.velichamgrow.com';

  static BaseOptions options = BaseOptions(baseUrl: "$scheme://$host/$scope");
  final Dio apiClient = Dio(options)
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
}