part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class SaveCurrentUser extends AppEvent {
  final AppUser? user;

  SaveCurrentUser({this.user});
}

