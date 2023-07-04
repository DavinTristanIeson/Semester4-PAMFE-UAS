import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memoir/helpers/styles.dart';

import '../../helpers/constants.dart';
import '../../models/flashcards.dart';

class FlashcardsPage extends StatefulWidget {
  final FlashcardSet flashcardSet;
  const FlashcardsPage({super.key, required this.flashcardSet});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  late List<Flashcard> bucket;
  int rememberedCount = 0;
  int index = 0;

  @override
  void initState() {
    bucket = widget.flashcardSet.cards.toList();
    shuffleBucket();
    super.initState();
  }

  void shuffleBucket() {
    final rng = Random();
    for (int i = 0; i < bucket.length; i++) {
      int target = i + rng.nextInt(bucket.length - i);
      final temp = bucket[target];
      bucket[target] = bucket[i];
      bucket[i] = temp;
    }
  }

  ButtonStyle buildActionStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.all(GAP_LG),
      side: const BorderSide(color: Colors.black, width: GAP_XS),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: GAP_XL, left: GAP, right: GAP),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: buildRememberButton(),
          ),
          const SizedBox(width: GAP_XL),
          Expanded(
            child: buildForgotButton(),
          )
        ],
      ),
    );
  }

  ElevatedButton buildForgotButton() {
    return ElevatedButton(
        onPressed: () => setState(() => bucket.removeAt(index)),
        style: buildActionStyle(),
        child: const Row(
          children: [
            Icon(Icons.cancel, color: COLOR_DANGER),
            Expanded(
              child: Center(
                child: Text(
                  "Forgot",
                  style: TextStyle(
                    color: COLOR_DANGER,
                    fontSize: FS_EMPHASIS,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  ElevatedButton buildRememberButton() {
    return ElevatedButton(
        onPressed: () => setState(() => bucket.removeAt(index)),
        style: buildActionStyle(),
        child: const Row(
          children: [
            Icon(Icons.check, color: COLOR_SUCCESS),
            Expanded(
              child: Center(
                child: Text(
                  "Remembered",
                  style: TextStyle(
                    color: COLOR_SUCCESS,
                    fontSize: FS_EMPHASIS,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildRestartButton() {
    return Tooltip(
      message: "Restart",
      child: Container(
        decoration: BoxDecoration(
          color: COLOR_SECONDARY,
          borderRadius: BorderRadius.circular(GAP_XL),
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              bucket = widget.flashcardSet.cards;
              index = 0;
            });
          },
          icon: const Icon(Icons.restart_alt),
        ),
      ),
    );
  }

  Widget buildCard() {
    Flashcard flashcard = bucket[index];
    if (index >= bucket.length) {
      shuffleBucket();
      index = 0;
    }
    if (bucket.isEmpty) {
      return buildRestartButton();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GAP_LG),
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(BR_LARGE)),
            boxShadow: BOX_SHADOW_DEFAULT,
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(GAP_LG).copyWith(top: GAP_XL + GAP_LG),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                flashcard.question,
                style: TEXT_IMPORTANT,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(gradient: VGRADIENT_PRIMARY_FADE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildGoBackButton(context),
          const SizedBox(height: GAP_XL),
          Expanded(child: buildCard()),
          const Spacer(),
          buildButtons(),
        ],
      ),
    ));
  }

  Widget buildGoBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GAP_LG),
      child: Container(
        decoration: BoxDecoration(
          color: COLOR_SECONDARY,
          borderRadius: BorderRadius.circular(GAP_XL),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
