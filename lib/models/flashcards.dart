import 'dart:io';

import 'package:memoir/models/account.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Flashcard {
  int id;
  String question;
  String answer;
  final parent = ToOne<FlashcardSet>();

  Flashcard(this.question, this.answer, {this.id = 0});
}

@Entity()
class FlashcardSet {
  int id;
  String title;
  String? description;
  List<String> tags;
  String? thumbnail;
  bool isPublic;

  @Backlink()
  final cards = ToMany<Flashcard>();

  final owner = ToOne<Account>();

  FlashcardSet({
    required this.title,
    required this.tags,
    this.description,
    this.thumbnail,
    this.isPublic = false,
    this.id = 0,
    List<Flashcard>? cards,
  });

  File? get image {
    return thumbnail != null ? File(thumbnail!) : null;
  }

  canBeModified(Account target) {
    return target.id == owner.target!.id;
  }
}
