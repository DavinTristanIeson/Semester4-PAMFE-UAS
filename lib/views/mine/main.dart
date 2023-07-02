import 'package:flutter/material.dart';
import 'package:memoir/components/display/flashcard.dart';
import 'package:memoir/components/display/future.dart';
import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/models/flashcards.dart';
import 'package:memoir/views/flashcard/create.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../models/account.dart';

class MyFlashcardsView extends StatelessWidget {
  final Account account;
  const MyFlashcardsView({super.key, required this.account});

  List<Widget> buildActions(BuildContext context, FlashcardSet set) {
    return set.canBeModified(account)
        ? [
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
              onPressed: () {},
              icon: const Icon(Icons.delete_forever),
              label: const Text("Delete"),
              style: BUTTON_DANGER,
            ),
          ]
        : [
            ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.copy),
                label: const Text("Copy"),
                style: BUTTON_PRIMARY),
            const SizedBox(width: GAP),
            ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.delete_outlined),
              label: const Text("Remove"),
              style: BUTTON_DANGER,
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return AsyncRender(
        future: FlashcardsController.getMyFlashcards(account),
        builder: (context, data) {
          List<FlashcardSet> sets = data ?? [];
          return ListView.builder(
              itemCount: sets.length,
              itemBuilder: (context, idx) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: GAP_SM, horizontal: GAP_LG),
                  child: FlashcardSetCard(
                    set: sets[idx],
                    onTap: null,
                    actions: buildActions(context, sets[idx]),
                  )));
        });
  }
}
