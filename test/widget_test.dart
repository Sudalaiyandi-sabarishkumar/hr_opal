import 'package:flutter/material.dart';
import 'package:flutter_bloc_bp/app.dart';
import 'package:flutter_bloc_bp/flavors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app loads', (WidgetTester tester) async {
    // REQUIRED for plugins that rely on WidgetsBinding
    TestWidgetsFlutterBinding.ensureInitialized();
    F.appFlavor = Flavor.dev;

    // Wrap App() with MaterialApp so Navigator + theme exist
    await tester.pumpWidget(
      const MaterialApp(
        home: App(), // or const App() depending on constructor
      ),
    );

    await tester.pump();

    expect(find.byType(App), findsOneWidget); // sanity check
  });
}
