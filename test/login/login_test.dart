import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_bp/views/app/bloc/app_bloc.dart';
import 'package:flutter_bloc_bp/views/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_bp/views/auth/ui/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers/my_test_app.dart';

void main() {
  setUp(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/shared_preferences'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{}; // set initial values here if desired
        }
        return null;
      },
    );
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  group('WIDGET TESTING ---> LoginPage() :-', () {
    testWidgets(
      'Checking presence of Appbar',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MyTestApp(
            appBloc: AppBloc(),
            authBloc: AuthBloc(),
            testWidget: const LoginPage(),
          ),
        );
        await tester.pumpAndSettle();
        final Finder appBarFinder = find.text('Flutter BLoC Boiler Plate');
        // final Finder appBarFinder = find.byType(Scaffold);
        expect(appBarFinder, findsOneWidget);
      },
    );
  });
}
