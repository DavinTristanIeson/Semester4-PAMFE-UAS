import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/components/display/text.dart';
import 'package:memoir/components/wrapper/gradient.dart';
import 'package:memoir/controller/flashcards.dart';
import 'package:memoir/models/flashcards.dart';
import 'package:memoir/views/flashcard/create/create_cards.dart';
import 'package:memoir/views/flashcard/create/create_detail.dart';

class CreateFlashcardsPage extends StatefulWidget {
  final FlashcardSet? set;
  const CreateFlashcardsPage({super.key, required this.set});

  @override
  State<CreateFlashcardsPage> createState() => _CreateFlashcardsPageState();
}

class _CreateFlashcardsPageState extends State<CreateFlashcardsPage>
    with SnackbarMessenger {
  FlashcardSet? flashcardSet;
  bool detailMode = true;
  @override
  void initState() {
    flashcardSet = widget.set;
    super.initState();
  }

  void save(FlashcardSet flashcardSet) {
    FlashcardsController.update(flashcardSet);
    this.flashcardSet = flashcardSet;
    // ignore: use_build_context_synchronously
    sendSuccess(context, "Successfully saved ${flashcardSet.title}");
  }

  PreferredSize buildAppBar() {
    return AppBarGradient(
        child: AppBar(
      title: const MemoirBrand(),
      actions: [
        detailMode
            ? Tooltip(
                message: flashcardSet == null
                    ? "Fill in the details first!"
                    : "Flashcards View",
                child: IconButton(
                    onPressed: flashcardSet == null
                        ? null
                        : () => setState(() => detailMode = false),
                    icon: const Icon(Icons.list)),
              )
            : Tooltip(
                message: "Metadata View",
                child: IconButton(
                    onPressed: () => setState(() => detailMode = true),
                    icon: const Icon(Icons.settings)),
              )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: detailMode || flashcardSet == null
          ? CreateFlashcardSetDetailView(
              flashcardSet: flashcardSet,
              onSave: save,
            )
          : CreateFlashcardSetCardsView(
              flashcardSet: flashcardSet!, onSave: save),
    );
  }
}
