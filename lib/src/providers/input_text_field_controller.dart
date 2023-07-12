import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_text_field_controller.g.dart';

@Riverpod(keepAlive: true)
Raw<TextEditingController> inputTextFieldController(
        InputTextFieldControllerRef ref) =>
    TextEditingController();
