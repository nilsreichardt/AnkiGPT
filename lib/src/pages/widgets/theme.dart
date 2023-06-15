import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF00FF7F));
final ankigptTheme = ThemeData(
  colorScheme: _colorScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: _colorScheme.inversePrimary,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: TargetPlatform.values.asMap().map(
          (key, value) => MapEntry(
            value,
            const FadeUpwardsPageTransitionsBuilder(),
          ),
        ),
  ),
);
