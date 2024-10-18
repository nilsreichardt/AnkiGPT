import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.hintText =
        '''Copy the text of a few slides and paste it into this text field.
Supports all languages.''',
  });

  final TextEditingController controller;
  final bool isEnabled;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.white24,
        width: 2,
      ),
    );
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
      minLines: 6,
      maxLines: 12,
      enabled: isEnabled,
      keyboardType: TextInputType.multiline,
    );
  }
}
