import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/token.dart';
import '../models/app_user.dart';

class PreferencesClient {
  PreferencesClient({required this.prefs});

  final SharedPreferences prefs;

  Future<AppUser?> getUser() async {
    final String? userString = await prefs.getString('appUser');
    if (userString == null || userString == '') {
      return null;
    }
    final dynamic user = json.decode(userString);
    return AppUser.fromJson(user);
  }

  void saveUser({AppUser? appUser}) {
    if (appUser == null) {
      prefs.setString('appUser', '');
      return;
    }
    final String userString = json.encode(appUser);
    prefs.setString('appUser', userString);
  }

  //****************************** user-access-token **************************//
  Future<Token?> getUserAccessToken() async {
    final String? tokenString = await prefs.getString('token');
    if (tokenString == null) {
      return null;
    }
    final dynamic accessToken = json.decode(tokenString);
    return Token.fromJson(accessToken);
  }

  void setUserAccessToken({Token? token}) {
    if (token == null) {
      prefs.setString('token', '');
      return;
    }
    final String tokenString = json.encode(token);
    prefs.setString('token', tokenString);
  }
}
