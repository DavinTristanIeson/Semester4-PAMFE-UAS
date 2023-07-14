import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/helpers/styles.dart';

import 'package:memoir/helpers/constants.dart';

import '../../components/display/flashcard.dart';

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
                    String tag = newTag == null
                        ? ""
                        : newTag
                            .trim()
                            .replaceAll(RegExp("\\s+"), '-')
                            .toLowerCase();
                    if (tag.isEmpty) {
                      return;
                    } else if (tags.contains(tag)) {
                      _tagsInput.clear();
                      _focus.requestFocus();
                      return;
                    }
                    tags.add(tag);

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
