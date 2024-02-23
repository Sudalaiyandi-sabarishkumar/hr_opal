import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/core/utils/utils.dart';
import 'package:flutter_bloc_bp/main.dart';
import 'package:flutter_bloc_bp/views/auth/ui/login_page.dart';
import 'package:flutter/material.dart';
import '../../app/bloc/app_bloc.dart';
import '../../home/home_page.dart';
import '../../loader/app_loader.dart';
import '../bloc/auth_bloc.dart';


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
        builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => current is CheckForPreferenceSuccess,
            builder: (context, state) {
              switch(state.runtimeType){
                case const (AuthLoading):
                  return const AppLoader();
                case const (CheckForPreferenceSuccess):
                  final currentState = state as CheckForPreferenceSuccess;
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
