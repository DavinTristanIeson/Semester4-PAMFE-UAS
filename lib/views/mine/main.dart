import 'package:flutter/material.dart';
import 'package:memoir/components/display/flashcard.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/components/function/future.dart';
import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/models/flashcards.dart';
import 'package:memoir/views/flashcard/create.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../models/account.dart';

class MyFlashcardsView extends StatelessWidget with SnackbarMessenger {
  final Account account;
  const MyFlashcardsView({super.key, required this.account});

  List<Widget> buildActions(BuildContext context, FlashcardSet set) {
    return [
      ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateFlashcardsPage(set: set)));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"),
        style: BUTTON_PRIMARY,
      ),
      const SizedBox(width: GAP),
      ElevatedButton.icon(
        onPressed: () {
          FlashcardsController.delete(set);
          sendSuccess(context, "${set.title} has been successfully deleted!");
        },
        icon: const Icon(Icons.delete_forever),
        label: const Text("Delete"),
        style: BUTTON_DANGER,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver(
        query: FlashcardsController.queryMyFlashcards(account),
        builder: (context, sets) {
          return ListView.builder(
              itemCount: sets.length,
              itemBuilder: (context, idx) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: GAP_SM, horizontal: GAP_LG),
                  child: FlashcardSetCard(
                    set: sets[idx],
                    actions: buildActions(context, sets[idx]),
                  )));
        });
  }
}
