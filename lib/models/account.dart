import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/models/common.dart';

class Account extends Identifiable {
  String email;
  late Digest _password;
  String name;
  String? bio;
  DateTime? birthdate;
  XFile? pfp;

  Account(
      {required this.email,
      required password,
      required this.name,
      required this.birthdate,
      required this.pfp,
      required this.bio})
      : super() {
    _password = Account.hash(password);
  }
  static Digest hash(String source) {
    return sha256.convert(utf8.encode(source));
  }

  bool checkPassword(String password) {
    Digest check = Account.hash(password);
    return check == _password;
  }

  bool canLogin(String email, String password) {
    return email == this.email && checkPassword(password);
  }

  bool changePassword(String password, String newPassword) {
    if (!checkPassword(password)) {
      return false;
    }
    _password = Account.hash(newPassword);
    return true;
  }
}

enum AccountQueryResult {
  NotFound("There are no accounts with that email."),
  Unauthorized("Email or password is wrong."),
  Ok(null);

  final String? message;
  const AccountQueryResult(this.message);
}

enum RegisterResult {
  HasDuplicate("Another account already exists with the same email"),
  Ok(null);

  final String? message;
  const RegisterResult(this.message);
}

class AccountCollection extends ChangeNotifier {
  SplayTreeMap<String, Account> db = SplayTreeMap();
  Result<AccountQueryResult, Account?> login(String email, String password) {
    if (!db.containsKey(email)) {
      return const Result(AccountQueryResult.NotFound, null);
    }
    Account account = db[email]!;
    if (account.canLogin(email, password)) {
      return Result(AccountQueryResult.Ok, account);
    } else {
      return const Result(AccountQueryResult.Unauthorized, null);
    }
  }

  RegisterResult register(Account account) {
    if (db.containsKey(account)) {
      return RegisterResult.HasDuplicate;
    } else {
      db[account.id] = account;
      notifyListeners();
      return RegisterResult.Ok;
    }
  }

  AccountQueryResult delete(Account account, String password) {
    if (!db.containsKey(account.email)) {
      return AccountQueryResult.NotFound;
    }
    if (!account.checkPassword(password)) {
      return AccountQueryResult.Unauthorized;
    }
    db.remove(account.email);
    notifyListeners();
    return AccountQueryResult.Ok;
  }

  // Karena key merupakan email, pengecekan pakai id jadi lambat. Disarankan selalu pakai email.
  Account? getById(String id) {
    return db.values.where((element) => element.id == id).firstOrNull;
  }
}
