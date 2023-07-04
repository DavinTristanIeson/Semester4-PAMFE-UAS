import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../models/flashcards.dart';

class FlippableFlashcard extends StatefulWidget {
  final Flashcard flashcard;
  const FlippableFlashcard({super.key, required this.flashcard});

  @override
  State<FlippableFlashcard> createState() => _FlippableFlashcardState();
}

class _FlippableFlashcardState extends State<FlippableFlashcard> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(BR_LARGE)),
            boxShadow: BOX_SHADOW_DEFAULT,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(GAP_LG),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isFlipped ? widget.flashcard.answer : widget.flashcard.question,
                style: TEXT_IMPORTANT,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
