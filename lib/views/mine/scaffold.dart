import 'package:flutter/material.dart';
import 'package:memoir/views/flashcard/create.dart';

class CreateFlashcardFAB extends StatelessWidget {
  const CreateFlashcardFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateFlashcardsPage(set: null)));
        },
        child: const Icon(Icons.add));
  }
}
