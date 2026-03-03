// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc_bp/core/bloc/auth_bloc/auth_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http_mock_adapter/http_mock_adapter.dart';

// import '../test_helpers/pump_route.dart';
// import 'login_mock.dart';

// void main() {
//   late Dio dio;
//   late DioAdapter dioAdapter;

//   setUp(() {
//     dio = Dio();
//     dioAdapter = DioAdapter(dio: dio, printLogs: true);
//   });

//   Future<AuthBloc> getAuthBloc(WidgetTester tester) async {
//     final ctx = tester.element(find.byKey(const Key('login_screen')));
//     return BlocProvider.of<AuthBloc>(ctx);
//   }
//   // TODO(add): Add all test cases for the login page to increase coverage.
//   group('Login Page Test Cases', () {
//     testWidgets('Displays all static elements correctly', (tester) async {
//       await tester.pumpRoute('/login', dioAdapter: dioAdapter);
//       await tester.pumpAndSettle();

//       expect(find.text('Login to your\naccount'), findsOneWidget);
//       expect(find.text('Email'), findsOneWidget);
//       expect(find.text('Password'), findsOneWidget);
//       expect(find.text('Login'), findsOneWidget);
//       expect(find.text('Forgot Password?'), findsOneWidget);
//       expect(find.text('Continue with Google'), findsOneWidget);
//     });

//     testWidgets('Login success API → AuthSuccess', (tester) async {
//       dioAdapter = LoginPageMockApi.setupMockAdapter(dio);

//       await tester.pumpRoute('/login', dioAdapter: dioAdapter);
//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(InputField).at(0), 'user@example.com');
//       await tester.enterText(find.byType(InputField).at(1), '123456');
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pumpAndSettle();

//       final bloc = await getAuthBloc(tester);
//       expect(bloc.state is AuthSuccess, true);
//     });

//     testWidgets('Invalid credentials → AuthError', (tester) async {
//       dioAdapter = LoginPageMockApi.setupMockAdapter(dio);

//       await tester.pumpRoute('/login', dioAdapter: dioAdapter);
//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(InputField).at(0), 'wrong@example.com');
//       await tester.enterText(find.byType(InputField).at(1), 'incorrect');
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pumpAndSettle();

//       final bloc = await getAuthBloc(tester);
//       expect(bloc.state is AuthError, true);
//     });

//     testWidgets('Server error → AuthError', (tester) async {
//       dioAdapter = LoginPageMockApi.setupMockAdapter(dio);

//       await tester.pumpRoute('/login', dioAdapter: dioAdapter);
//       await tester.pumpAndSettle();

//       await tester.enterText(find.byType(InputField).at(0), 'server@error.com');
//       await tester.enterText(find.byType(InputField).at(1), '123456');
//       await tester.tap(find.byType(ElevatedButton));
//       await tester.pumpAndSettle();

//       final bloc = await getAuthBloc(tester);
//       expect(bloc.state is AuthError, true);
//     });
//   });
// }
