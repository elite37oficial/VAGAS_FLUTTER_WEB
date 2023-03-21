import 'environment_config.dart';

class EnviromentDEV implements EnvironmentConfig {
  static final EnviromentDEV _singleton = EnviromentDEV._internal();

  EnviromentDEV._internal();

  factory EnviromentDEV() {
    return _singleton;
  }

  @override
  String baseURL = "http://apivagasdev.elite37.com.br";
}

class EnviromentHMG implements EnvironmentConfig {
  static final EnviromentHMG _singleton = EnviromentHMG._internal();

  EnviromentHMG._internal();

  factory EnviromentHMG() {
    return _singleton;
  }

  @override
  String baseURL = "http://apivagashmg.elite37.com.br";
}

class EnviromentPROD implements EnvironmentConfig {
  static final EnviromentPROD _singleton = EnviromentPROD._internal();

  EnviromentPROD._internal();

  factory EnviromentPROD() {
    return _singleton;
  }

  @override
  String baseURL = "http://apivagas.elite37.com.br";
}
