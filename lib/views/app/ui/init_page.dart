import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/main.dart';
import 'package:flutter_bloc_bp/views/auth/ui/login_page.dart';
import 'package:flutter/material.dart';
import '../../home/home_page.dart';
import '../../loader/app_loader.dart';
import '../bloc/app_bloc.dart';


class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  @override
  void initState() {
    appBloc.add(CheckForPreference());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          switch(state.runtimeType){
            case const (AppLoading):
              return const AppLoader();
            case const (CheckForPreferenceSuccess):
              final currentState = state as CheckForPreferenceSuccess;
              if(currentState.user != null){
                return HomePage(user: currentState.user);
              }else{
                return const LoginPage();
              }
            default:
              return const AppLoader();
          }
        });
  }
}
