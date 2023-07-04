import 'package:memoir/controller/account.dart';
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
    db.remove(set.id);
  }

  static FlashcardSet fork(FlashcardSet original, Account forker) {
    FlashcardSet newSet = FlashcardSet(
      title: original.title,
      description: original.description,
      tags: original.tags,
      isPublic: original.isPublic,
      thumbnail: original.thumbnail,
    );
    newSet.forkedFrom.target = original;
    newSet.cards.addAll(original.cards);
    newSet.owner.target = forker;

    db.put(newSet);
    forker.flashcards.add(newSet);
    AccountController.update(forker);
    return newSet;
  }

  static QueryBuilder<FlashcardSet> queryMyFlashcards(Account account) {
    return db.query(FlashcardSet_.owner.equals(account.id));
  }

  static QueryBuilder<FlashcardSet> queryPublicFlashcards(Account account) {
    return db
        .query(FlashcardSet_.owner
            .notEquals(account.id)
            .and(FlashcardSet_.isPublic.equals(true)))
        .order(FlashcardSet_.id, flags: Order.descending);
  }
}
