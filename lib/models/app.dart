import 'package:flutter/material.dart';
import 'package:memoir/controller/account.dart';

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

  void deleteAccount(String password) {
    if (_account == null) return;
    AccountController.delete(_account!, password);
    notifyListeners();
  }
}

class SearchProvider extends ChangeNotifier {
  String _search = '';
  String get search => _search;
  set search(String term) {
    _search = term;
    notifyListeners();
  }
}
