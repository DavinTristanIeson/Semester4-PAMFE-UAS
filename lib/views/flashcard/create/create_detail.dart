import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../input.dart';
import '../../../components/wrapper/input.dart';
import '../../../controller/common.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/validators.dart';
import '../../../models/account.dart';
import '../../../models/app.dart';
import '../../../models/flashcards.dart';

final GlobalKey<FormBuilderState> _detailKey = GlobalKey();

class CreateFlashcardSetDetailView extends StatelessWidget {
  final FlashcardSet? flashcardSet;
  final void Function(FlashcardSet) onSave;
  const CreateFlashcardSetDetailView(
      {super.key, required this.flashcardSet, required this.onSave});

  void save(BuildContext context) async {
    if (_detailKey.currentState == null) {
      throw Exception(
          "Cannot find the Create Flashcards form in the Widget tree. Did you forget to put the key into the form?");
    }
    final FormBuilderState state = _detailKey.currentState!;
    if (!state.validate()) return;

    Account account = context.read<AppStateProvider>().account!;
    final newFlashcardSet = FlashcardSet(
      title: state.fields["title"]!.value,
      description: state.fields["description"]!.value,
      tags: state.fields["tags"]!.value ?? [],
      thumbnail: state.fields["thumbnail"]!.value != null
          ? (await saveImage(state.fields["thumbnail"]!.value,
                  former: flashcardSet?.thumbnail))
              .path
          : null,
      isPublic: state.fields["isPublic"]!.value ?? false,
      id: flashcardSet?.id ?? 0,
    );
    newFlashcardSet.owner.target = account;
    onSave(newFlashcardSet);
  }

  Widget buildDetailForm() {
    return ListView(
      padding: const EdgeInsets.all(GAP),
      children: [
        TextInputField(
          name: "title",
          label: "Title",
          placeholder: "Enter title",
          validator: isNotEmpty("Title should not be empty."),
        ),
        const TextInputField(
          name: "description",
          validator: noValidate,
          label: "Description",
          placeholder: "Enter description",
          isTextarea: true,
        ),
        TagsInputField(name: "tags"),
        ImageInputField(
          name: "thumbnail",
          label: "Thumbnail",
          validator: noValidate,
          placeholder: "Upload Thumbnail",
        ),
        const SwitchInputField(name: "isPublic", label: "Open to Public"),
        const SizedBox(height: GAP_XL * 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _detailKey,
      initialValue: {
        "title": flashcardSet?.title,
        "description": flashcardSet?.description,
        "tags": flashcardSet?.tags,
        "isPublic": flashcardSet?.isPublic,
        "thumbnail": flashcardSet?.thumbnail != null
            ? XFile(flashcardSet!.thumbnail!)
            : null,
      },
      child: Stack(
        children: [
          buildDetailForm(),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(GAP),
              child: FloatingActionButton(
                onPressed: () => save(context),
                child: const Icon(Icons.save),
              ),
            ),
          )
        ],
      ),
    );
  }
}
