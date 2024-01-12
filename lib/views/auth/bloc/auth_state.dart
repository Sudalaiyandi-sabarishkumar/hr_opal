part of 'auth_bloc.dart';

abstract class AuthState extends ErrorState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}

class LogOutSuccess extends AuthState {}

class LoginWithPasswordSuccess extends AuthState {
  AppUser? user;

  LoginWithPasswordSuccess({this.user});
}
