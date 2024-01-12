import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_bp/base_bloc/base_bloc.dart';
import 'package:flutter_bloc_bp/models/app_user.dart';
import '../../../api_repository/auth_service.dart';

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
      emit(loginWithPasswordSuccess..user = user);
  }

  FutureOr<void> _logOut(LogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    emit(LogOutSuccess());
  }

  @override
  Future<void> eventHandlerMethod(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event.runtimeType) {
      case LoginWithPassword:
        return _loginWithPassword(event as LoginWithPassword, emit);
      case LogOut:
        return _logOut(event as LogOut, emit);
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
