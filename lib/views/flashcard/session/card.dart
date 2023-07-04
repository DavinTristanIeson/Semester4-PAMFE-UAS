import 'dart:math';

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

  Widget flipAnimationTransition(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(isFlipped) == widget!.key;
        final rotationY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(widget.flashcard.id),
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: flipAnimationTransition,
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: buildCard(),
      ),
    );
  }

  // CREDIT: https://stackoverflow.com/questions/54958897/flutter-flip-animation-flip-a-card-over-its-right-or-left-side-based-on-the
  Widget buildCard() {
    return Container(
        key: ValueKey(isFlipped),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(BR_LARGE)),
          boxShadow: BOX_SHADOW_DEFAULT,
          color: Colors.white,
        ),
        constraints: const BoxConstraints(
          minHeight: 200.0,
        ),
        padding: const EdgeInsets.all(GAP_LG),
        child: Column(
          children: [
            Text(isFlipped ? "Answer" : "Question",
                style: const TextStyle(
                  fontSize: FS_LARGE,
                  fontWeight: FontWeight.bold,
                )),
            const Padding(
              padding: EdgeInsets.only(
                  bottom: GAP, top: GAP_XS, left: GAP_LG, right: GAP_LG),
              child: Divider(),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFlipped
                      ? widget.flashcard.answer
                      : widget.flashcard.question,
                  style: const TextStyle(
                    fontSize: FS_EMPHASIS,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ));
  }
}
