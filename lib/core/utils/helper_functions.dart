import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../preference_client/preference_client.dart';
import '../../views/auth/ui/login_page.dart';

Future<void> forceLogOut(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  PreferencesClient(prefs: prefs).saveUser();
  PreferencesClient(prefs: prefs).setUserAccessToken();
  if (context.mounted) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => const LoginPage(),
        ),
        (Route<dynamic> route) => false);
  }
}
