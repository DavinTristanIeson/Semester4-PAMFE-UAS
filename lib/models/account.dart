import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import '../objectbox.g.dart';
// ignore: unnecessary_import
import 'package:objectbox/objectbox.dart';
import 'flashcards.dart';

@Entity()
class Account {
  int id;
  @Unique(onConflict: ConflictStrategy.fail)
  String email;
  String password;
  String name;
  String? bio;
  @Property(type: PropertyType.date)
  DateTime? birthdate;
  String? pfp;

  @Backlink("owner")
  final flashcards = ToMany<FlashcardSet>();
  Account(
      {required this.email,
      required this.password,
      required this.name,
      this.pfp,
      this.birthdate,
      this.bio,
      this.id = 0});
  static Digest hash(String source) {
    return sha256.convert(utf8.encode(source));
  }

  File? get image {
    return pfp != null ? File(pfp!) : null;
  }

  bool checkPassword(String password) {
    Digest check = Account.hash(password);
    return check.toString() == this.password;
  }

  bool canLogin(String email, String password) {
    return email == this.email && checkPassword(password);
  }

  bool changePassword(String currentPassword, String newPassword) {
    if (!checkPassword(currentPassword)) {
      return false;
    }

    final hashedPassword = Account.hash(newPassword).toString();
    password = hashedPassword;
    return true;
  }

  @override
  bool operator ==(Object other) {
    return other is Account && other.id == id;
  }

  @override
  int get hashCode => id;
}
