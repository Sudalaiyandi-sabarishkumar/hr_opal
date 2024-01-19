
enum Flavor { production, staging }

class AppConfig {
  String appName = "";
  String baseUrl = "";
  Flavor flavor = Flavor.staging;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    String baseUrl = "",
    Flavor flavor = Flavor.staging,
  }) {
    return shared = AppConfig(appName, baseUrl, flavor);
  }

  AppConfig(this.appName, this.baseUrl, this.flavor);
}