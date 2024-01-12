import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_bp/base_bloc/base_bloc.dart';
import 'package:flutter_bloc_bp/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_repository/auth_service.dart';
import '../../../core/utils/utils.dart';
import '../../../models/token.dart';
import '../../../preference_client/preference_client.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final authService = AuthService();

  LoginWithPasswordSuccess loginWithPasswordSuccess = LoginWithPasswordSuccess();

  FutureOr<void> _loginWithPassword(
      LoginWithPassword event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      final Map<String, dynamic> objToApi = <String, dynamic>{
        "employee": {
          "email": event.mobile ?? '',
          "password": event.password ?? '',
          "build_number": 100,
          "is_mobile": true,
          "grant_type": "password"
        }
      };
      final Map<String, dynamic>? response =
      await authService.loginWithPassword(objToApi: objToApi);
      final AppUser? user = response?['customer'];
      final Token? token = response?['token'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      PreferencesClient(prefs: prefs).saveUser(appUser: user);
      PreferencesClient(prefs: prefs).setUserAccessToken(token: token);
      emit(loginWithPasswordSuccess..user = user);
  }

  FutureOr<void> _logOut(LogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token? token = PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, String> headersToApi = await Utils.getHeader(token?.accessToken);
    await authService.logOut(headersToApi: headersToApi);
    PreferencesClient(prefs: prefs).saveUser();
    emit(LogOutSuccess());
  }

  @override
  Future<void> eventHandlerMethod(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event.runtimeType) {
      case const (LoginWithPassword):
        return _loginWithPassword(event as LoginWithPassword, emit);
      case const (LogOut):
        return _logOut(event as LogOut, emit);
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
