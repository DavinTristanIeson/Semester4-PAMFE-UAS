import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memoir/components/display/background.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/models/app.dart';
import 'package:provider/provider.dart';

import '../../../helpers/constants.dart';
import '../../../models/account.dart';
import '../../../models/flashcards.dart';
import 'card.dart';

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

  Widget buildForgotButton() {
    return Tooltip(
      message:
          "You forgot the answer to this question, and would like to retry this again later",
      child: ElevatedButton(
          onPressed: () => setState(() => index++),
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
          )),
    );
  }

  Widget buildRememberButton() {
    return Tooltip(
      message:
          "You already know the answer to this question, and would like it removed from the stack of flashcards.",
      child: ElevatedButton(
          onPressed: () => setState(() => bucket.removeAt(index)),
          style: buildActionStyle(),
          child: const Row(
            children: [
              Icon(Icons.check, color: COLOR_SUCCESS),
              Expanded(
                child: Center(
                  child: Text(
                    "Know",
                    style: TextStyle(
                      color: COLOR_SUCCESS,
                      fontSize: FS_EMPHASIS,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildRestartButton() {
    return Container(
      decoration: const BoxDecoration(
        color: COLOR_FADED_50,
        borderRadius: BorderRadius.all(Radius.circular(BR_LARGE)),
      ),
      padding: const EdgeInsets.all(GAP_LG),
      child: Column(
        children: [
          Text(
              "Congratulations, you've completed all flashcards of ${widget.flashcardSet.title}!",
              textAlign: TextAlign.center,
              style: TEXT_IMPORTANT),
          const SizedBox(height: GAP),
          const Text(
            "Do you want to try again?",
            textAlign: TextAlign.center,
            style: TEXT_IMPORTANT,
          ),
          const SizedBox(height: GAP_XL),
          Tooltip(
            message: "Restart",
            child: Container(
              decoration: BoxDecoration(
                color: COLOR_PRIMARY,
                borderRadius: BorderRadius.circular(GAP_XL),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    bucket = widget.flashcardSet.cards.toList();
                    shuffleBucket();
                    index = 0;
                  });
                },
                icon: const Icon(Icons.restart_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    if (index >= bucket.length) {
      shuffleBucket();
      index = 0;
    }
    if (bucket.isEmpty) {
      return buildRestartButton();
    }
    Flashcard flashcard = bucket[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GAP_LG),
      child: FlippableFlashcard(
        flashcard: flashcard,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    Account account = context.watch<AppStateProvider>().account!;
    if (widget.flashcardSet.cards.isEmpty) {
      return Scaffold(
          body: PlayfulCircleBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGoBackButton(context),
            const SizedBox(height: GAP_XL),
            ErrorComponent(
              title: "No Cards Found",
              reason:
                  "This flashcard set doesn't seem to have any flashcards yet.${widget.flashcardSet.owner.target!.id == account.id ? " Try creating one!" : ""}",
            )
          ],
        ),
      ));
    }

    return Scaffold(
        body: PlayfulCircleBackground(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildGoBackButton(context),
            buildCard(context),
            const Spacer(),
            if (bucket.isNotEmpty) buildButtons(),
          ],
        ),
      ),
    ));
  }
}
