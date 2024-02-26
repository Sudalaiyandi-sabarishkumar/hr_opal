import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../app/bloc/app_bloc.dart';
import '../auth/bloc/auth_bloc.dart';
import '../auth/ui/login_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      authBloc.stream.listen((AuthState state) => (mounted ? onAuthBlocChange(context: context, state: state):null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          appBar:
              AppBar(title:  BlocBuilder<AppBloc, AppState>(
                  builder: (BuildContext context, AppState state) {
                  return Text('Welcome ${appBloc.stateData.user?.firstname ?? ''}');
                }
              )),
          body: Center(
            child: Column(
              children: <Widget>[
                if (state is AuthLoading) const Text('Logging out...') else Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              authBloc.add(LogOut());
                            },
                            child: const Text('Logout')),
                      ],
                    ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }


  void onAuthBlocChange({required BuildContext context, required AuthState state}) {
    switch(state.runtimeType){
      case const (LogOutSuccess):
        Navigator.pushReplacement(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => BlocProvider<AuthBloc>.value(
                value: AuthBloc(),
                child: const LoginPage(),
              ),
            ));
    }
  }
}
