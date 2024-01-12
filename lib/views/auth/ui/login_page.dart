import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/views/home/home_page.dart';

import '../../../main.dart';
import '../bloc/auth_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authBloc.stream.listen((state) => (mounted ? onAuthBlocChange(context, state):null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SafeArea(
          child: Column(children: [
        Expanded(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Text('Logging in...');
                      } else {
                        return ElevatedButton(
                            onPressed: () {
                              authBloc.add(LoginWithPassword(
                                  'TCRO1', 'Password@123'));
                            },
                            child: const Text('Login'));
                      }
                    }
                  ),
                ))),
      ])),
      // globalLoader(authViewModel.isLoading)
    ]));
  }

  void onAuthBlocChange(context, state) {
    switch(state.runtimeType){
      case LoginWithPasswordSuccess:
        final currentState = state as LoginWithPasswordSuccess;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(user: currentState.user),
            ));
      case AuthError:
        final currentState = state as AuthError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(currentState.errorMsg),
        ));
    }
  }
}
