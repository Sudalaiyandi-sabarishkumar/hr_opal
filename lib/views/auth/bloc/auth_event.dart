part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginWithPassword extends AuthEvent {
  final String? mobile;
  final String? password;

  LoginWithPassword(this.mobile, this.password);
}

class LogOut extends AuthEvent {}

