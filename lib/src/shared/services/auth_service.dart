import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool isAuthenticated = false;

  loged() {
    isAuthenticated = true;
    notifyListeners();
  }

  logouted() {
    isAuthenticated = false;
    notifyListeners();
  }
}
