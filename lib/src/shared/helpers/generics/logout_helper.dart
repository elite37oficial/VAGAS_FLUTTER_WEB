import 'dart:developer';

import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

abstract class LogoutHelper {
  static Future<bool> logout() async {
    try {
      await SecureStorageManager.deleteData(StorageKeys.accessToken);
      await SecureStorageManager.deleteData(StorageKeys.email);
      await SecureStorageManager.deleteData(StorageKeys.name);
      await SecureStorageManager.deleteData(StorageKeys.phone);
      await SecureStorageManager.deleteData(StorageKeys.role);
      await SecureStorageManager.deleteData(StorageKeys.userId);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
