import 'package:flutter/material.dart';
import 'package:memoir/components/display/flashcard.dart';
import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/models/flashcards.dart';

import '../../components/function/future.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../models/account.dart';

class BrowseView extends StatelessWidget {
  final Account account;
  const BrowseView({super.key, required this.account});

  List<Widget> buildActions(FlashcardSet set) {
    return [
      ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.bookmark),
          label: const Text("Save"),
          style: ElevatedButton.styleFrom(
            backgroundColor: COLOR_SUCCESS,
            shape: const StadiumBorder(),
            textStyle: TEXT_BTN_PRIMARY,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver(
        query: FlashcardsController.queryPublicFlashcards(account),
        builder: (context, sets) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: sets.length,
              itemBuilder: (context, idx) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: GAP_SM, horizontal: GAP_LG),
                  child: FlashcardSetCard(
                    set: sets[idx],
                    onTap: () {},
                    actions: buildActions(sets[idx]),
                  )));
        });
  }
}
