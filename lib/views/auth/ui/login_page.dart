import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../../app/bloc/app_bloc.dart';
import '../../home/home_page.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      authBloc.stream.listen(
          (AuthState state) => (mounted ? onAuthBlocChange(context: context, state: state) : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: <Widget>[
        Expanded(
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, AuthState state) {
                    if (state is AuthLoading) {
                      return const Text('Logging in...');
                    } else {
                      return ElevatedButton(
                          onPressed: () {
                            authBloc.add(
                                LoginWithPassword('TCRO1', 'Password@123'));
                          },
                          child: const Text('Login'));
                    }
                  }),
                ))),
      ])),
    );
  }

  void onAuthBlocChange({required BuildContext context, required AuthState state}) {
    switch (state.runtimeType) {
      case const (LoginWithPasswordSuccess):
        final LoginWithPasswordSuccess currentState = state as LoginWithPasswordSuccess;
        appBloc.add(SaveCurrentUser(user: currentState.user));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => const HomePage(),
            ));
      case const (AuthError):
        final AuthError currentState = state as AuthError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(currentState.errorMsg),
        ));
    }
  }
}
