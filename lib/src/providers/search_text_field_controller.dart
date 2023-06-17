import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_text_field_controller.g.dart';

@Riverpod(keepAlive: true)
Raw<TextEditingController> searchTextFieldController(
  SearchTextFieldControllerRef ref,
) {
  return TextEditingController();
}
