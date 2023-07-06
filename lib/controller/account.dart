import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/objectbox.g.dart';
// ignore: unnecessary_import
import 'package:objectbox/objectbox.dart';

import '../models/account.dart';
import '../models/common.dart';
import 'common.dart';

class AccountController {
  static Box<Account> get db {
    return store.box<Account>();
  }

  static Account login(String email, String password) {
    final query = db.query(Account_.email.equals(email)).build();
    Account? account = query.findFirst();
    if (account == null) {
      throw UserException("There are no accounts with that email.");
    }
    if (!account.canLogin(email, password)) {
      throw UserException("Email or password is wrong.");
    }
    return account;
  }

  static bool canRegister(String email) {
    final query = db.query(Account_.email.equals(email)).build();
    Account? same = query.findFirst();
    return same == null;
  }

  static int register(Account account) {
    try {
      return db.put(account, mode: PutMode.insert);
    } on UniqueViolationException catch (_) {
      throw UserException("Another account already exists with the same email");
    }
  }

  static void delete(Account account, String password) {
    if (!account.checkPassword(password)) {
      throw UserException(
          "Password doesn't match the account's actual password.");
    }
    store.runInTransaction(TxMode.write, () {
      for (final set in account.flashcards) {
        FlashcardsController.delete(set);
      }
      db.remove(account.id);
      if (account.pfp != null) {
        deleteImage(account.pfp!);
      }
    });
  }

  static update(Account account) {
    db.put(account, mode: PutMode.update);
  }
}
