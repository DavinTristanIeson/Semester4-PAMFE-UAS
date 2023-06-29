import 'package:image_picker/image_picker.dart';
import 'package:memoir/models/account.dart';

class Flashcard {
  String question;
  String answer;
  XFile? thumbnail;
  Flashcard(this.question, this.answer, {this.thumbnail});
  copy() {
    return Flashcard(question, answer, thumbnail: thumbnail);
  }
}

class FlashcardSet {
  String title;
  String description;
  List<String> tags;
  late final Account _owner;
  XFile? thumbnail;
  bool isPublic;
  late List<Flashcard> cards;
  FlashcardSet({
    required this.title,
    required this.description,
    required this.tags,
    required Account owner,
    this.thumbnail,
    this.isPublic = false,
    List<Flashcard>? cards,
  }) {
    _owner = owner;
    this.cards = cards ?? [];
  }

  Account get owner {
    return _owner;
  }

  fork(Account newOwner) {
    return FlashcardSet(
        title: title,
        description: description,
        tags: tags,
        owner: newOwner,
        thumbnail: thumbnail,
        isPublic: isPublic,
        cards: cards.map<Flashcard>((x) => x.copy()).toList());
  }

  canModify(Account target) {
    return target == _owner;
  }
}
