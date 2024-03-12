import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/auth/ui/init_page.dart';
import 'views/auth/ui/login_page.dart';
import 'views/home/home_page.dart';
import 'views/loader/app_loader.dart';

class RouteConstants {
  static String initPage = 'init';
  static String appLoaderPage = 'appLoader';
  static String loginPage = 'login';
  static String homePage = 'home';
}

class AppRouter {
  static GoRouter getRouter({String initialLocation = '/'}) => GoRouter(
        initialLocation: initialLocation,
        routes: <RouteBase>[
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
        ],
      );
}
