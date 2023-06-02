import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/app_widget.dart';
import 'package:vagas_flutter_web/src/shared/utils/environment_config/environment_config.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/app_routes_implementation.dart';

Future<void> buildApp(EnvironmentEnum environmentArgs) async {
  environmentConfig = environmentArgs;

  String? loged = await SecureStorageManager.readData(StorageKeys.loged);

  String? role = await SecureStorageManager.readData(StorageKeys.role);

  if (role == "admin" && loged != null) {
    authService.adminLoged();
  } else if (role != "admin" && loged != null) {
    authService.loged();
  }

  setupLocator();

  runApp(const AppWidget());
}
