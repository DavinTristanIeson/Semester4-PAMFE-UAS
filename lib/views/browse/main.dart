import 'package:flutter/material.dart';
import 'package:memoir/components/display/flashcard.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/models/app.dart';
import 'package:memoir/models/flashcards.dart';
import 'package:provider/provider.dart';

import '../../components/function/future.dart';
import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import '../../models/account.dart';

class BrowseView extends StatelessWidget with SnackbarMessenger {
  final Account account;
  const BrowseView({super.key, required this.account});

  List<Widget> buildActions(BuildContext context, FlashcardSet set) {
    return [
      ElevatedButton.icon(
          onPressed: () {
            try {
              FlashcardsController.fork(set, account);
              sendSuccess(context, "Saved ${set.title} to your library!");
            } catch (e) {
              sendError(context, e.toString());
            }
          },
          icon: const Icon(Icons.save),
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
    String search = context.watch<SearchProvider>().search;
    return QueryObserver(
        query: FlashcardsController.queryPublicFlashcards(account, search),
        builder: (context, sets) {
          return ListView.builder(
              shrinkWrap: true,
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
