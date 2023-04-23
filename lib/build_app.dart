import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator.dart';
import 'package:vagas_flutter_web/src/shared/utils/app_widget.dart';
import 'package:vagas_flutter_web/src/shared/utils/environment_config/environment_config.dart';

Future<void> buildApp(EnvironmentEnum environmentArgs) async {
  environmentConfig = environmentArgs;

  setupLocator();

  runApp(const AppWidget());
}
