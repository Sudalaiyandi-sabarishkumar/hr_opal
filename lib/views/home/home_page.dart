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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return Scaffold(
          appBar:
              AppBar(title:  BlocBuilder<AppBloc, AppState>(
                  builder: (BuildContext context, AppState state) {
                  return Text('Welcome ${appBloc.stateData.user?.firstname ?? ''}', style: textTheme.titleLarge);
                }
              )),
          body: Center(
            child: Column(
              children: <Widget>[
                if (state is AuthLoading) Text('Logging out...', style: textTheme.bodyMedium) else Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              authBloc.add(LogOut());
                            },
                            child: Text('Logout', style: textTheme.bodyMedium?.copyWith(color: colorScheme.error))),
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
