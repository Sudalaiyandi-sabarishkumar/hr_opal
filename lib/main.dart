import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/views/app/bloc/app_bloc.dart';
import 'package:flutter_bloc_bp/views/app/ui/init_page.dart';
import 'package:flutter_bloc_bp/views/auth/bloc/auth_bloc.dart';
import 'base_bloc/base_bloc.dart';

final AuthBloc authBloc = AuthBloc();
final AppBloc appBloc = AppBloc();
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  Bloc.observer = AppBlocObserver();

  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => authBloc),
            BlocProvider(create: (context) => appBloc),
          ],
          child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'MyApp',
      home: const InitPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
