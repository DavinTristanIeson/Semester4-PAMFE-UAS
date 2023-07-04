import 'package:flutter/material.dart';

import 'account.dart';

class AppStateProvider extends ChangeNotifier {
  Account? _account;
  Account? get account => _account;
  set account(Account? account) {
    _account = account;
    notifyListeners();
  }

  void logout() {
    _account = null;
    notifyListeners();
  }

  bool deleteAccount(String password) {
    if (_account != null) {
      bool success = _account!.deleteAccount(password);
      if (success) {
        _account = null;
        notifyListeners();
      }
      return success;
    }
    return false;
  }
}
