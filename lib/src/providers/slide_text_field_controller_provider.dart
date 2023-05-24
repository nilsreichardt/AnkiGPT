import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final slideTextFieldControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
