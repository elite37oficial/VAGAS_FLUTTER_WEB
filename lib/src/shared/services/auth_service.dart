import 'package:flutter/material.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class AuthService extends ChangeNotifier {
  bool isAuthenticated = false;
  bool isAdminAuthenticated = false;

  loged() async {
    isAuthenticated = true;
    await SecureStorageManager.saveData(StorageKeys.loged, "loged");
    notifyListeners();
  }
  adminLoged() async {
    isAdminAuthenticated = true;
    await SecureStorageManager.saveData(StorageKeys.loged, "loged");
    notifyListeners();
  }

  logouted() async {
    isAuthenticated = false;
    isAdminAuthenticated = false;
    await SecureStorageManager.deleteData(StorageKeys.loged);
    notifyListeners();
  }
}
