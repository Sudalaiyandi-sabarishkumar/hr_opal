enum Flavor { production, staging, dev, qa }

class AppConfig {
  AppConfig({
    required this.flavor,
    required this.appName,
    required this.scheme,
    required this.scope,
    required this.host,
    required this.baseUrl,
  });
  factory AppConfig.initiate() {
    const String environment = String.fromEnvironment('ENVIRONMENT');
    const String appName = String.fromEnvironment('APP_NAME');
    const String scheme = String.fromEnvironment('SCHEME');
    const String scope = String.fromEnvironment('SCOPE');
    const String host = String.fromEnvironment('HOST');

    return shared = AppConfig(
      flavor: (environment == Flavor.dev.name)
          ? Flavor.dev
          : (environment == Flavor.qa.name)
              ? Flavor.qa
              : (environment == Flavor.staging.name)
                  ? Flavor.staging
                  : Flavor.production,
      appName: appName,
      scheme: scheme,
      scope: scope,
      host: host,
      baseUrl: '$scheme://$scope',
      
    );
  }
  Flavor flavor;
  String appName;
  String scheme;
  String scope;
  String host;
  String baseUrl;

  static AppConfig shared = AppConfig.initiate();
}
