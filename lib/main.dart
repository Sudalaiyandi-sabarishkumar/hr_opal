import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:nested/nested.dart';
import 'app_config.dart';
import 'base_bloc/base_bloc.dart';
import 'views/app/bloc/app_bloc.dart';
import 'views/auth/bloc/auth_bloc.dart';
import 'views/auth/ui/init_page.dart';

final AuthBloc authBloc = AuthBloc();
final AppBloc appBloc = AppBloc();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// flavor & env setup
  await FlutterConfig.loadEnvVariables();
  AppConfig.initiate();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  Bloc.observer = AppBlocObserver();

  runApp(
      MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AppBloc>(create: (BuildContext context) => appBloc),
            BlocProvider<AuthBloc>(create: (BuildContext context) => authBloc),
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
      debugShowCheckedModeBanner: AppConfig.shared.flavor == Flavor.staging,
    );
  }
}
