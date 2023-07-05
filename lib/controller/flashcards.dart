import 'package:memoir/controller/account.dart';
import 'package:memoir/controller/common.dart';
import 'package:memoir/models/flashcards.dart';

import '../models/account.dart';
import '../models/common.dart';
import '../objectbox.g.dart';

class FlashcardsController {
  static Box<FlashcardSet> get db {
    return store.box<FlashcardSet>();
  }

  static Box<Flashcard> get cards {
    return store.box<Flashcard>();
  }

  static void update(FlashcardSet set) {
    cards.putMany(set.cards);
    db.put(set);
  }

  static void delete(FlashcardSet set) {
    store.runInTransaction(TxMode.write, () {
      db.removeMany(set.cards.map<int>((card) => card.id).toList());
      if (!db.remove(set.id)) {
        throw UserException(
            "The flashcard set you're trying to delete doesn't seem to exist?");
      }
    });
  }

  static FlashcardSet fork(FlashcardSet original, Account forker) {
    FlashcardSet newSet = FlashcardSet(
      title: original.title,
      description: original.description,
      tags: original.tags,
      isPublic: original.isPublic,
      thumbnail: original.thumbnail,
    );
    newSet.forkedFrom.target = original.owner.target;
    newSet.cards.addAll(
        original.cards.map((card) => Flashcard(card.question, card.answer)));
    newSet.owner.target = forker;

    db.put(newSet);
    forker.flashcards.add(newSet);
    AccountController.update(forker);
    return newSet;
  }

  static QueryBuilder<FlashcardSet> queryMyFlashcards(
      Account account, String search) {
    Condition<FlashcardSet> condition = FlashcardSet_.owner.equals(account.id);
    if (search.isNotEmpty) {
      condition = condition
          .and(FlashcardSet_.title.contains(search, caseSensitive: false))
          .or(FlashcardSet_.tags.containsElement(search));
    }
    return db.query(condition);
  }

  static QueryBuilder<FlashcardSet> queryPublicFlashcards(
      Account account, String search) {
    Condition<FlashcardSet> condition = FlashcardSet_.owner
        .notEquals(account.id)
        .and(FlashcardSet_.isPublic.equals(true));
    if (search.isNotEmpty) {
      condition = condition
          .and(FlashcardSet_.title.contains(search, caseSensitive: false))
          .or(FlashcardSet_.tags.containsElement(search, caseSensitive: false));
    }
    return db.query(condition).order(FlashcardSet_.id, flags: Order.descending);
  }
}
