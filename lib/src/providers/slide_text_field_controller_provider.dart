import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'slide_text_field_controller_provider.g.dart';

@riverpod
Raw<TextEditingController> slideTextFieldController(
        SlideTextFieldControllerRef ref) =>
    TextEditingController();
