import 'package:flutter/material.dart';
import 'package:memoir/views/flashcard/input.dart';

import '../../helpers/constants.dart';
import '../../models/flashcards.dart';

class CreateFlashcardSetCardsView extends StatelessWidget {
  final FlashcardSet flashcardSet;
  final void Function(FlashcardSet) onSave;
  const CreateFlashcardSetCardsView(
      {super.key, required this.flashcardSet, required this.onSave});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CreateFlashcardFieldArray(flashcards: flashcardSet.cards),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(GAP),
            child: FloatingActionButton(
              onPressed: () => onSave(flashcardSet),
              child: const Icon(Icons.save),
            ),
          ),
        )
      ],
    );
  }
}
