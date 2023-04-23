import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static const prefs = FlutterSecureStorage();

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      await prefs.write(key: key, value: value);
      return true;
    } else {
      log("Invalid Type");
      throw TypeError();
    }
  }

  static Future<String?> readData(String key) async {
    String? obj = await prefs.read(key: key);
    return obj;
  }

  static Future deleteData(String key) async {
    return await prefs.delete(key: key);
  }
}
