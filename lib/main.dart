import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import 'app.dart';
import 'core/api_repository/api_repository.dart';
import 'core/bloc/auth_bloc/auth_bloc.dart';
import 'core/config/app_config.dart';
import 'flavors.dart';

Future<void> main() async {
  // ✅ Zone-based error handling
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Flavor setup (unchanged)
      F.appFlavor = Platform.environment.containsKey('FLUTTER_TEST')
          ? Flavor.dev
          : Flavor.values.firstWhere(
              (Flavor f) => f.name == appFlavor,
              orElse: () => Flavor.dev,
            );

      AppConfig.fromFlavor(F.appFlavor);

      await ApiRepository.init();

      await Firebase.initializeApp();
      // ✅ Enable / Disable Crashlytics by build mode
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
        !kDebugMode,
      );

      // ✅ Flutter framework errors
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      // ✅ Async & platform errors
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      runApp(
        MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
          ],
          child: const App(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}
