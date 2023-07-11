import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFCECECE),
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
          hoverColor: Colors.white,
          fillColor: Colors.white,
          hintText:
              '''Copy the text of a few slides and paste it into this text field.
Supports all languages.''',
          hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
      minLines: 6,
      maxLines: 12,
      enabled: isEnabled,
      keyboardType: TextInputType.multiline,
    );
  }
}
