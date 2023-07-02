import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/models/flashcards.dart';

import 'package:memoir/helpers/constants.dart';

import '../../components/display/flashcard.dart';

class _CreateFlashcardInput extends StatefulWidget {
  final Flashcard flashcard;
  final void Function({
    String question,
    String answer,
  }) onChanged;
  final void Function()? onDelete;
  final void Function()? onShiftUp;
  final void Function()? onShiftDown;

  const _CreateFlashcardInput(
      {super.key,
      required this.flashcard,
      required this.onChanged,
      this.onDelete,
      this.onShiftUp,
      this.onShiftDown});

  @override
  State<_CreateFlashcardInput> createState() => _CreateFlashcardInputState();
}

class _CreateFlashcardInputState extends State<_CreateFlashcardInput> {
  late final Flashcard flashcard;
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;
  @override
  void initState() {
    _questionController =
        TextEditingController(text: widget.flashcard.question);
    _answerController = TextEditingController(text: widget.flashcard.answer);
    flashcard = widget.flashcard;
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  InputDecoration buildInputDecor(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: BORDER_INPUT,
      fillColor: Colors.white,
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(BR_LARGE)),
          border: BORDER_THICK,
        ),
        width: double.maxFinite,
        padding: const EdgeInsets.all(GAP),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFieldLabel(
              label: "Question",
              child: TextField(
                decoration: buildInputDecor("Enter Question"),
                controller: _questionController,
                onChanged: (value) {
                  widget.onChanged(question: value);
                },
              ),
            ),
            InputFieldLabel(
              label: "Answer",
              child: TextField(
                decoration: buildInputDecor("Enter Answer"),
                controller: _answerController,
                onChanged: (value) {
                  widget.onChanged(answer: value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.onDelete != null)
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete, color: COLOR_DANGER),
                  ),
                IconButton(
                  onPressed: widget.onShiftDown,
                  icon: Icon(Icons.arrow_downward,
                      color: widget.onShiftDown != null
                          ? COLOR_PRIMARY
                          : COLOR_DISABLED),
                ),
                IconButton(
                  onPressed: widget.onShiftUp,
                  icon: Icon(Icons.arrow_upward,
                      color: widget.onShiftUp != null
                          ? COLOR_PRIMARY
                          : COLOR_DISABLED),
                ),
              ],
            ),
          ],
        ));
  }
}

class CreateFlashcardFieldArray extends StatefulWidget {
  final List<Flashcard> flashcards;
  const CreateFlashcardFieldArray({
    super.key,
    required this.flashcards,
  });

  @override
  State<CreateFlashcardFieldArray> createState() =>
      _CreateFlashcardFieldArrayState();
}

class _CreateFlashcardFieldArrayState extends State<CreateFlashcardFieldArray> {
  late final List<Flashcard> cards;
  @override
  void initState() {
    cards = widget.flashcards;
    super.initState();
  }

  Widget buildCreateFlashcardButton() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            indent: GAP,
            endIndent: GAP,
            color: Colors.black,
          ),
        ),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                cards.add(Flashcard("", ""));
              });
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Flashcard")),
        const Expanded(
          child: Divider(
            indent: GAP,
            endIndent: GAP,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(GAP),
        itemCount: cards.length + 1,
        itemBuilder: (context, idx) {
          if (idx == cards.length) {
            return buildCreateFlashcardButton();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: GAP),
            child: _CreateFlashcardInput(
              key: ObjectKey(cards[idx]),
              flashcard: cards[idx],
              onChanged: ({
                String? question,
                String? answer,
              }) =>
                  setState(() {
                cards[idx].question = question ?? cards[idx].question;
                cards[idx].answer = answer ?? cards[idx].answer;
              }),
              onDelete: () => setState(() {
                cards.removeAt(idx);
              }),
              onShiftDown: idx == cards.length - 1
                  ? null
                  : () {
                      setState(() {
                        final cur = cards[idx];
                        cards[idx] = cards[idx + 1];
                        cards[idx + 1] = cur;
                      });
                    },
              onShiftUp: idx == 0
                  ? null
                  : () {
                      setState(() {
                        final cur = cards[idx];
                        cards[idx] = cards[idx - 1];
                        cards[idx - 1] = cur;
                      });
                    },
            ),
          );
        });
  }
}

class TagsInputField extends StatelessWidget {
  final TextEditingController _tagsInput = TextEditingController();
  final FocusNode _focus = FocusNode();
  final String name;
  TagsInputField({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>>(
        name: name,
        builder: (state) {
          List<String> tags = state.value ?? [];
          return InputFieldLabel(
            label: "Tags",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: tags.isNotEmpty
                      ? const EdgeInsets.symmetric(vertical: GAP)
                      : const EdgeInsets.only(),
                  child: Wrap(children: [
                    for (int i = 0; i < tags.length; i++)
                      Tag(
                          tag: tags[i],
                          onDelete: () {
                            tags.removeAt(i);
                            state.didChange(tags);
                          })
                  ]),
                ),
                TextField(
                  focusNode: _focus,
                  decoration: const InputDecoration(
                    hintText: "Enter Tag",
                    border: BORDER_INPUT,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: _tagsInput,
                  onSubmitted: (String? newTag) {
                    if (newTag == null) {
                      return;
                    } else if (tags.contains(newTag)) {
                      _tagsInput.clear();
                      _focus.requestFocus();
                      return;
                    }
                    tags.add(newTag.split(' ').join('-').toLowerCase());

                    state.didChange(tags);
                    _tagsInput.clear();
                    _focus.requestFocus();
                  },
                )
              ],
            ),
          );
        });
  }
}
