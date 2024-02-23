import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_bp/base_bloc/base_bloc.dart';
import 'package:flutter_bloc_bp/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_repository/auth_service.dart';
import '../../../preference_client/preference_client.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  final authService = AuthService();

  StateData stateData = StateData();

  FutureOr<void> _saveCurrentUser(
      SaveCurrentUser event, Emitter<AppState> emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      PreferencesClient(prefs: prefs).saveUser(appUser: event.user);
      emit(stateData..user = event.user);
  }

  @override
  Future<void> eventHandlerMethod(AppEvent event, Emitter<AppState> emit) async {
    switch (event.runtimeType) {
      case const (SaveCurrentUser):
        return _saveCurrentUser(event as SaveCurrentUser, emit);
    }
  }

  @override
  AppState getErrorState() {
    return AppError();
  }
}
