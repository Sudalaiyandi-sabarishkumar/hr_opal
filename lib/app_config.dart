import 'package:flutter_config/flutter_config.dart';

enum Flavor { production, staging }

class AppConfig {
  Flavor flavor;
  String appLabel;
  String scheme;
  String scope;
  String host;

  static AppConfig shared = AppConfig.initiate();

  factory AppConfig.initiate() {
    return shared = AppConfig(
        flavor: (FlutterConfig.get('ENVIRONMENT') == 'staging') ? Flavor.staging : Flavor.production,
        appLabel: FlutterConfig.get('APP_LABEL'),
        scheme: FlutterConfig.get('SCHEME'),
        scope: FlutterConfig.get('SCOPE'),
        host: FlutterConfig.get('HOST'));
  }

  AppConfig({required this.flavor, required this.appLabel, required this.scheme, required this.scope, required this.host});
}