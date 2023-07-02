import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/helpers/strings.dart';
import 'package:memoir/helpers/styles.dart';

import '../../helpers/constants.dart';

class InputFieldLabel extends StatelessWidget {
  final Widget child;
  final String label;
  const InputFieldLabel({super.key, required this.child, required this.label});

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
  final String? initialValue;
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
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return InputFieldLabel(
      label: label,
      child: FormBuilderTextField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        validator: validator,
        initialValue: initialValue,
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

class DateTimeInputField extends StatefulWidget {
  final String name;
  final DateTime? initialValue;
  final String? Function(DateTime?) validator;
  final String label;
  final String? placeholder;
  const DateTimeInputField(
      {super.key,
      required this.name,
      required this.label,
      this.placeholder,
      required this.validator,
      this.initialValue});

  @override
  State<DateTimeInputField> createState() => _DateTimeInputFieldState();
}

class _DateTimeInputFieldState extends State<DateTimeInputField> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    return InputFieldLabel(
      label: widget.label,
      child: FormBuilderField<DateTime>(
          name: widget.name,
          validator: widget.validator,
          initialValue: widget.initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            String? value = state.value != null
                ? "${state.value!.day.pad0(2)}/${state.value!.month.pad0(2)}/${state.value!.year.pad0(4)}"
                : null;
            _controller.text = value ?? "";
            return InkWell(
              onTap: () async {
                state.didChange(await getDate(context, state.value));
              },
              child: TextField(
                enabled: false,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
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
  final XFile? initialValue;
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
      required this.validator,
      this.initialValue});

  Widget buildImageName(String title) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
          decoration: const BoxDecoration(color: COLOR_DARKEN_50),
          padding: const EdgeInsets.all(GAP),
          child: Text(title.trimBeyond(40), style: TEXT_SMALL_DETAIL)),
    );
  }

  Widget buildImageBody(XFile? image) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(GAP)),
          gradient: VGRADIENT_DISABLED_FADE,
          border: Border.all(color: Colors.black54, width: 1.0),
        ),
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
    return InputFieldLabel(
      label: label,
      child: FormBuilderField<XFile>(
          name: name,
          initialValue: initialValue,
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
                      buildImageName(field.value!.name),
                    if (field.errorText != null)
                      Positioned.fill(
                        child: Container(
                            decoration: const BoxDecoration(
                              color: COLOR_DARKEN_50,
                            ),
                            child: Center(
                                child: Text(field.errorText!,
                                    style: TEXT_ERROR_IMPORTANT))),
                      ),
                  ],
                ));
          }),
    );
  }
}

class SwitchInputField extends StatelessWidget {
  final String name;
  final String label;
  final bool? initialValue;
  const SwitchInputField(
      {super.key, required this.name, required this.label, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
        name: name,
        initialValue: initialValue,
        builder: (state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TEXT_IMPORTANT),
              Switch(
                value: state.value ?? false,
                onChanged: state.didChange,
              )
            ],
          );
        });
  }
}
