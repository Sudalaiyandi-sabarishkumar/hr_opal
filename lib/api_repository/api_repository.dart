import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../app_config.dart';

class ApiRepository {
  static String scheme = 'https';
  static String scope = 'api/v1';
  static String host = AppConfig.shared.baseUrl;

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