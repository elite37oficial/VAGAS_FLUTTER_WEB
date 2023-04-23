import 'environment_config_implementation.dart';

enum EnvironmentEnum { dev, hmg, prod }

late final EnvironmentEnum environmentConfig;

abstract class EnvironmentConfig {
  late String baseURL;
}

class EnvironmentFactory {
  EnvironmentConfig getEnvironment() {
    switch (environmentConfig) {
      case EnvironmentEnum.dev:
        return EnviromentDEV();
      case EnvironmentEnum.hmg:
        return EnviromentHMG();
      case EnvironmentEnum.prod:
        return EnviromentPROD();

      default:
        return EnviromentDEV();
    }
  }
}
