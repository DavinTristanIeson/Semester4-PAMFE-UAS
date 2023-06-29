import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/components/wrapper/touchable.dart';
import 'package:memoir/helpers/strings.dart';
import 'package:memoir/helpers/styles.dart';

import '../../helpers/constants.dart';

class _InputFieldLabel extends StatelessWidget {
  final Widget child;
  final String label;
  const _InputFieldLabel({required this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: GAP_SM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TEXT_IMPORTANT),
            const SizedBox(height: GAP_SM),
            child,
          ],
        ));
  }
}

class TextInputField extends StatelessWidget {
  final String name;
  final String? Function(String?) validator;
  final String label;
  final String? placeholder;
  final bool? obscureText;
  final bool? isTextarea;
  const TextInputField({
    super.key,
    required this.name,
    required this.validator,
    required this.label,
    this.placeholder,
    this.obscureText,
    this.isTextarea,
  });
  @override
  Widget build(BuildContext context) {
    return _InputFieldLabel(
      label: label,
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        validator: validator,
        decoration: InputDecoration(
          hintText: placeholder,
          border: BORDER_INPUT,
          fillColor: Colors.white,
          filled: true,
        ),
        minLines: isTextarea != null && isTextarea! ? 6 : null,
        maxLines: obscureText != null && obscureText!
            ? 1
            : isTextarea != null && isTextarea!
                ? null
                : 1,
        obscureText: obscureText ?? false,
      ),
    );
  }
}

class DateTimeInputField extends StatelessWidget {
  final String name;
  final String? Function(DateTime?) validator;
  final String label;
  final String? placeholder;
  const DateTimeInputField(
      {super.key,
      required this.name,
      required this.label,
      this.placeholder,
      required this.validator});

  Future<DateTime?> getDate(BuildContext context, DateTime? value) {
    const FOUR_YEARS = Duration(days: 365 * 4);
    return showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now().subtract(FOUR_YEARS),
        firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
        lastDate: DateTime.now().subtract(FOUR_YEARS),
        initialEntryMode: DatePickerEntryMode.inputOnly);
  }

  @override
  Widget build(BuildContext context) {
    return _InputFieldLabel(
      label: label,
      child: FormBuilderField<DateTime>(
          name: name,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            String? value = state.value != null
                ? "${state.value!.day.pad0(2)}/${state.value!.month.pad0(2)}/${state.value!.year.pad0(4)}"
                : null;
            return InkWell(
              onTap: () async {
                state.didChange(await getDate(context, state.value));
              },
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: value),
                decoration: InputDecoration(
                  hintText: placeholder,
                  border: BORDER_INPUT,
                  fillColor: Colors.white,
                  filled: true,
                ),
                readOnly: true,
              ),
            );
          }),
    );
  }
}

class ImageInputField extends StatelessWidget {
  final String name;
  final ImagePicker _picker = ImagePicker();
  final String? Function(XFile?) validator;
  final String label;
  final String? placeholder;
  final double height;
  ImageInputField(
      {super.key,
      required this.name,
      required this.label,
      this.height = 300.0,
      this.placeholder,
      required this.validator});

  Widget buildImageName(String title) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          padding: const EdgeInsets.all(GAP),
          child: Text(title.trimBeyond(40), style: TEXT_SMALL_DETAIL)),
    );
  }

  Widget buildImageBody(XFile? image) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(GAP)),
            gradient: VGRADIENT_DISABLED_FADE),
        height: height,
        child: Center(
            child: image != null
                ? Image.file(File(image.path), height: 300.0, fit: BoxFit.cover)
                : placeholder != null
                    ? Text(placeholder!,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ))
                    : null));
  }

  @override
  Widget build(BuildContext context) {
    return _InputFieldLabel(
      label: label,
      child: FormBuilderField<XFile>(
          name: name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          builder: (FormFieldState<XFile> field) {
            return GestureDetector(
                onTap: () async {
                  final result =
                      await _picker.pickImage(source: ImageSource.gallery);
                  field.didChange(result);
                },
                child: Stack(
                  children: [
                    buildImageBody(field.value),
                    if (field.value?.name != null)
                      buildImageName(field.value!.name)
                  ],
                ));
          }),
    );
  }
}
