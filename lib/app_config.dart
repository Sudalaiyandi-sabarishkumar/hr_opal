enum Flavor { production, staging, dev }

class AppConfig {
  AppConfig({
    required this.flavor,
    required this.appLabel,
    required this.scheme,
    required this.scope,
    required this.host,
    required this.baseUrl,
  });
  factory AppConfig.initiate() {
    const String environment = String.fromEnvironment('ENVIRONMENT');
    const String appLabel = String.fromEnvironment('APP_LABEL');
    const String scheme = String.fromEnvironment('SCHEME');
    const String scope = String.fromEnvironment('SCOPE');
    const String host = String.fromEnvironment('HOST');

    return shared = AppConfig(
      flavor: (environment == Flavor.dev.name)
          ? Flavor.dev
          : (environment == Flavor.staging.name)
              ? Flavor.staging
              : Flavor.production,
      appLabel: appLabel,
      scheme: scheme,
      scope: scope,
      host: host,
      baseUrl: '$scheme://$scope/$host',
    );
  }
  Flavor flavor;
  String appLabel;
  String scheme;
  String scope;
  String host;
  String baseUrl;

  static AppConfig shared = AppConfig.initiate();
}
