import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/auth/forgot_password.dart';
import 'views/auth/init_page.dart';
import 'views/auth/landing_page.dart';
import 'views/auth/login_page.dart';


import 'views/auth/otp_page.dart';
import 'views/auth/sign_in_page.dart';
import 'views/design/design_page.dart';
import 'views/home/home_page.dart';
import 'views/loader/app_loader.dart';

class FirebaseUtils {
  static bool isFlutterTest = Platform.environment.containsKey('FLUTTER_TEST');
}
class RouteConstants {
  static String initPage = 'init';
  static String appLoaderPage = 'appLoader';
  static String landingPage = 'landing';
  static String signInPage = 'signIn';
  static String forgotPasswordPage = 'forgotPassword';
  static String otpPage = 'otp';
  static String loginPage = 'login';
  static String homePage = 'home';
  static String designPage = 'design';
}

class GoRouterInit {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String initialLocation = '/';
  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();
  static Object? initialExtra;

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[
      GoRouterInit.routeObserver,
      if (!FirebaseUtils.isFlutterTest)
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    initialLocation: initialLocation,
    initialExtra: initialExtra,
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      // Init Page
       GoRoute(
            path: '/',
            name: RouteConstants.initPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<InitPage>(
              child: InitPage(),
            ),
          ),
          GoRoute(
            path: '/loader',
            name: RouteConstants.appLoaderPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<AppLoader>(
              child: AppLoader(),
            ),
          ),
          GoRoute(
            path: '/auth/landing',
            name: RouteConstants.landingPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<LandingPage>(
              child: LandingPage(),
            ),
          ),
          GoRoute(
            path: '/auth/sign-in',
            name: RouteConstants.signInPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<SignInPage>(
              child: SignInPage(),
            ),
          ),
          GoRoute(
            path: '/auth/forgot-password',
            name: RouteConstants.forgotPasswordPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<ForgotPasswordPage>(
              child: ForgotPasswordPage(),
            ),
          ),
          GoRoute(
            path: '/auth/otp',
            name: RouteConstants.otpPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                MaterialPage<OtpPage>(
              child: OtpPage(
                maskedMobileNumber: state.extra is String
                    ? state.extra! as String
                    : '966*******56',
              ),
            ),
          ),
          GoRoute(
            path: '/auth/login',
            name: RouteConstants.loginPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<LoginPage>(
              child: LoginPage(),
            ),
          ),
          GoRoute(
            path: '/home',
            name: RouteConstants.homePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<HomePage>(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/design',
            name: RouteConstants.designPage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<DesignPage>(
              child: DesignPage(),
            ),
          ),
    ],
  );
}