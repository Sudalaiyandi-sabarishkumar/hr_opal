part of 'app_bloc.dart';

abstract class AppState extends ErrorState {}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppError extends AppState {}

class CheckForPreferenceSuccess extends AppState {
  AppUser? user;

  CheckForPreferenceSuccess({this.user});
}
