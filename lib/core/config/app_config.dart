import '../../flavors.dart';

class AppConfig {

  // Private constructor
  AppConfig._internal({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  /// Initialize ONCE
  factory AppConfig.fromFlavor(Flavor flavor) {
    if (!_initialized) {
      late final String baseUrlConfig;

      switch (flavor) {
        case Flavor.dev:
          baseUrlConfig = 'https://api-staging.vuka.co.ke/api/';

        case Flavor.staging:
          baseUrlConfig = 'https://api-staging.vuka.co.ke/api/';

        case Flavor.prod:
          baseUrlConfig = 'vuka.com';
      }

      shared = AppConfig._internal(
        flavor: flavor,
        appName: F.title,
        baseUrl: baseUrlConfig,
      );

      _initialized = true;
    }

    return shared;
  }
  // Singleton always exists (after initialization)
  static late final AppConfig shared;

  // Track first-time initialization
  static bool _initialized = false;

  // Fields
  final Flavor flavor;
  final String appName;
  final String baseUrl;
}
