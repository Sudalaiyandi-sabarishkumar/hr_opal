import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_bp/base_bloc/base_bloc.dart';
import 'package:flutter_bloc_bp/models/app_user.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import '../../../api_repository/auth_service.dart';
import '../../../preference_client/preference_client.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  final authService = AuthService();

  CheckForPreferenceSuccess checkForPreferenceSuccess = CheckForPreferenceSuccess();

  FutureOr<void> _checkForPreference(
      CheckForPreference event, Emitter<AppState> emit) async {
      emit(AppLoading());
      final SecureSharedPref prefs = await SecureSharedPref.getInstance();
      AppUser? user = await PreferencesClient(prefs: prefs).getUser();
      emit(checkForPreferenceSuccess..user = user);
  }

  @override
  Future<void> eventHandlerMethod(AppEvent event, Emitter<AppState> emit) async {
    switch (event.runtimeType) {
      case const (CheckForPreference):
        return _checkForPreference(event as CheckForPreference, emit);
    }
  }

  @override
  AppState getErrorState() {
    return AppError();
  }
}
