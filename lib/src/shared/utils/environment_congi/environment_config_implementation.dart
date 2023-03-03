import 'environment_config.dart';

class EnviromentDEV implements EnvironmentConfig {
  static final EnviromentDEV _singleton = EnviromentDEV._internal();

  EnviromentDEV._internal();

  factory EnviromentDEV() {
    return _singleton;
  }

  @override
  String baseURL = "http://teste.com";
}

class EnviromentHMG implements EnvironmentConfig {
  static final EnviromentHMG _singleton = EnviromentHMG._internal();

  EnviromentHMG._internal();

  factory EnviromentHMG() {
    return _singleton;
  }

  @override
  String baseURL = "http://teste.com";
}

class EnviromentPROD implements EnvironmentConfig {
  static final EnviromentPROD _singleton = EnviromentPROD._internal();

  EnviromentPROD._internal();

  factory EnviromentPROD() {
    return _singleton;
  }

  @override
  String baseURL = "http://teste.com";
}
