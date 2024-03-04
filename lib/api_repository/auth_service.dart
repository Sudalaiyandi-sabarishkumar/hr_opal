import 'dart:async';
import 'package:dio/dio.dart';
import '../models/app_user.dart';
import '../models/token.dart';
import 'api_repository.dart';


class AuthService extends ApiRepository {

//************************************ log-in *********************************//
  Future<Map<String, dynamic>?> loginWithPassword(
      {Map<String, dynamic>? objToApi}) async {
    final Response<dynamic> res = await apiClient.post(
      '/user_management/customer/auth/login',
      data: objToApi
    );
    return <String, dynamic>{'customer': AppUser.fromJson(res.data['contact'] as Map<String, dynamic>), 'token': Token.fromJson(res.data['token'] as Map<String, dynamic>)};
  }

//************************************ log-out *********************************//
  Future<Response<dynamic>> logOut(
      {Map<String, String>? headersToApi}) async {
    final Response<dynamic> res = await apiClient.delete(
      '/user_management/customer/auth/logout',
      options: Options(headers: headersToApi)
    );
    return res;
  }
}
