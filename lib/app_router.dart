import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/auth/init_page.dart';
import 'views/auth/login_page.dart';
import 'views/badges_showcase/badges_showcase_page.dart';
import 'views/chips_showcase/chips_showcase_page.dart';
import 'views/home/home_page.dart';
import 'views/loader/app_loader.dart';
import 'views/tabs_showcase/tabs_showcase_page.dart';
import 'views/toast_showcase/toast_showcase_page.dart';
import 'views/tooltip_showcase/tooltip_showcase_page.dart';

class FirebaseUtils {
  static bool isFlutterTest = Platform.environment.containsKey('FLUTTER_TEST');
}
class RouteConstants {
  static String initPage = 'init';
  static String appLoaderPage = 'appLoader';
  static String loginPage = 'login';
  static String homePage = 'home';
  static String tabsShowcasePage = 'tabsShowcase';
  static String badgesShowcasePage = 'badgesShowcase';
  static String chipsShowcasePage = 'chipsShowcase';
  static String toastShowcasePage = 'toastShowcase';
  static String tooltipShowcasePage = 'tooltipShowcase';
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
            path: '/tabs-showcase',
            name: RouteConstants.tabsShowcasePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<TabsShowcasePage>(
              child: TabsShowcasePage(),
            ),
          ),
          GoRoute(
            path: '/badges-showcase',
            name: RouteConstants.badgesShowcasePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<BadgesShowcasePage>(
              child: BadgesShowcasePage(),
            ),
          ),
          GoRoute(
            path: '/chips-showcase',
            name: RouteConstants.chipsShowcasePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<ChipsShowcasePage>(
              child: ChipsShowcasePage(),
            ),
          ),
          GoRoute(
            path: '/toast-showcase',
            name: RouteConstants.toastShowcasePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<ToastShowcasePage>(
              child: ToastShowcasePage(),
            ),
          ),
          GoRoute(
            path: '/tooltip-showcase',
            name: RouteConstants.tooltipShowcasePage,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const MaterialPage<TooltipShowcasePage>(
              child: TooltipShowcasePage(),
            ),
          ),
    ],
  );
}
