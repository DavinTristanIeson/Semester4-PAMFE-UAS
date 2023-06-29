import 'package:flutter/material.dart';

import 'account.dart';

class AppStateProvider extends ChangeNotifier {
  Account? _account;
  Account? get account => _account;
  set account(Account? account) {
    _account = account;
    notifyListeners();
  }
}
