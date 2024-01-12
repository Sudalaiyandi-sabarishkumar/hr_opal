
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_bp/api_repository/api_repository.dart';
import 'package:flutter_bloc_bp/models/access_token.dart';
import 'package:flutter_bloc_bp/models/app_user.dart';


class AuthService extends ApiRepository {

//************************************ log-in *********************************//
  Future<Map<String, dynamic>?> loginWithPassword(
      {Map<String, dynamic>? objToApi}) async {
    final Response res = await apiClient.post(
      '/user_management/employee/login',
      data: objToApi
    );
    return {'customer': AppUser.fromJson(res.data['employee']), 'token': Token.fromJson(res.data['token'])};
  }
}
