import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_bp/app_config.dart';
import 'package:flutter_bloc_bp/theme.dart';
import 'package:flutter_bloc_bp/views/app/bloc/app_bloc.dart';
import 'package:flutter_bloc_bp/views/auth/bloc/auth_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested/nested.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyTestApp extends StatefulWidget {
  const MyTestApp({
    super.key,
    required this.appBloc,
    required this.authBloc,
    required this.testWidget,
  });
  final Widget testWidget;
  final AppBloc appBloc;
  final AuthBloc authBloc;

  @override
  MyTestAppState createState() => MyTestAppState();
}

class MyTestAppState extends State<MyTestApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AppBloc>(create: (BuildContext context) => widget.appBloc),
        BlocProvider<AuthBloc>(create: (BuildContext context) => widget.authBloc),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 835),
        builder: (_, Widget? child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: themeData,
            home: widget.testWidget,
            debugShowCheckedModeBanner: AppConfig.shared.flavor == Flavor.staging,
          );
        },
      ),
    );
  }
}
