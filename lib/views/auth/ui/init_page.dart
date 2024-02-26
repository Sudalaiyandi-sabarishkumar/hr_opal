import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/utils.dart';
import '../../../main.dart';
import '../../app/bloc/app_bloc.dart';
import '../../home/home_page.dart';
import '../../loader/app_loader.dart';
import '../bloc/auth_bloc.dart';
import 'login_page.dart';


class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  void initState() {
    authBloc.add(CheckForPreference());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
        return BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (AuthState previous, AuthState current) => current is CheckForPreferenceSuccess,
            builder: (BuildContext context, AuthState state) {
              switch(state.runtimeType){
                case const (AuthLoading):
                  return const AppLoader();
                case const (CheckForPreferenceSuccess):
                  final CheckForPreferenceSuccess currentState = state as CheckForPreferenceSuccess;
                  appBloc.add(SaveCurrentUser(user: currentState.user));
                  if(Utils.nullOrEmpty(currentState.user?.firstname)){
                    return const LoginPage();
                  }else{
                    return const HomePage();
                  }
                default:
                  return const AppLoader();
              }
            });
      }
    );
  }
}
