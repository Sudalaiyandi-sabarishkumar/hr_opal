import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/views/auth/ui/login_page.dart';

import '../../models/app_user.dart';
import '../auth/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  final AppUser? user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar:
              AppBar(title: Text('Welcome ${widget.user?.firstname ?? ''}')),
          body: Center(
            child: Column(
              children: [
                (state is AuthLoading)
                    ? const Text('Logging out...')
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _authBloc.add(LogOut());
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
      listener: (BuildContext context, AuthState state) {
        if (state is LogOutSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider<AuthBloc>.value(
                  value: AuthBloc(),
                  child: const LoginPage(),
                ),
              ));
        }
      },
    );
  }
}
