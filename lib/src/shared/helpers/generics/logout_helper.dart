import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/app_routes_implementation.dart';
import 'package:vagas_flutter_web/src/shared/utils/routes/route_keys.dart';

abstract class LogoutHelper {
  static logout(BuildContext context) {
    try {
      SecureStorageManager.deleteData(StorageKeys.accessToken);
      SecureStorageManager.deleteData(StorageKeys.email);
      SecureStorageManager.deleteData(StorageKeys.name);
      SecureStorageManager.deleteData(StorageKeys.phone);
      SecureStorageManager.deleteData(StorageKeys.role);
      SecureStorageManager.deleteData(StorageKeys.userId);
      authService.logouted();
      context.pushReplacement(RouteKeys.auth);
    } catch (e) {
      log(e.toString());
    }
  }
}
