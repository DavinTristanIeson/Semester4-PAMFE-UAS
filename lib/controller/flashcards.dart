import 'package:memoir/controller/common.dart';
import 'package:memoir/models/flashcards.dart';

import '../models/account.dart';
import '../objectbox.g.dart';

class FlashcardsController {
  static Box<FlashcardSet> get db {
    return store.box<FlashcardSet>();
  }

  static Box<Flashcard> get cards {
    return store.box<Flashcard>();
  }

  static void update(FlashcardSet set) {
    db.put(set);
  }

  static void delete(FlashcardSet set) {
    db.put(set);
  }

  static QueryBuilder<FlashcardSet> queryMyFlashcards(Account account) {
    return db
        .query(FlashcardSet_.owner.equals(account.id))
        .order(FlashcardSet_.id, flags: Order.descending);
  }

  static QueryBuilder<FlashcardSet> queryPublicFlashcards(Account account) {
    return db
        .query(FlashcardSet_.owner.notEquals(account.id))
        .order(FlashcardSet_.id, flags: Order.descending);
  }
}
