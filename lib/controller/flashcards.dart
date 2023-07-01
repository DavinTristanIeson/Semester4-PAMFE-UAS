import 'package:memoir/controller/common.dart';
import 'package:memoir/models/flashcards.dart';

import '../objectbox.g.dart';

class FlashcardsController {
  Box<FlashcardSet> get db {
    return store.box<FlashcardSet>();
  }

  Box<Flashcard> get cards {
    return store.box<Flashcard>();
  }
}
