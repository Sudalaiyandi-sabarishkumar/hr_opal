import 'dart:convert';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../models/token.dart';
import '../models/app_user.dart';

class PreferencesClient {
  PreferencesClient({required this.prefs});

  final SecureSharedPref prefs;

  Future<AppUser?> getUser() async {
    final String? userString = await prefs.getString('appUser', isEncrypted: true);
    if (userString == null || userString == '') {
      return null;
    }
    final dynamic user = json.decode(userString);
    return AppUser.fromJson(user);
  }

  void saveUser({AppUser? appUser}) {
    if (appUser == null) {
      prefs.putString('appUser', '', isEncrypted: true);
      return;
    }
    final String userString = json.encode(appUser);
    prefs.putString('appUser', userString, isEncrypted: true);
  }

  //****************************** user-access-token **************************//
  Future<Token?> getUserAccessToken() async {
    final String? tokenString = await prefs.getString('token', isEncrypted: true);
    if (tokenString == null) {
      return null;
    }
    final dynamic accessToken = json.decode(tokenString);
    return Token.fromJson(accessToken);
  }

  void setUserAccessToken({Token? token}) {
    if (token == null) {
      prefs.putString('token', '', isEncrypted: true);
      return;
    }
    final String tokenString = json.encode(token);
    prefs.putString('token', tokenString, isEncrypted: true);
  }
}
