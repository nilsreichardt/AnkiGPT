import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF00FF7F),
);
const darkGreen = Color(0xFF001D0E);

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
  fontFamily: 'Ubuntu',
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: darkGreen,
        displayColor: darkGreen,
      ),
  scaffoldBackgroundColor: const Color(0xFFE9FFF4),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: TargetPlatform.values.asMap().map(
          (key, value) => MapEntry(
            value,
            const FadeUpwardsPageTransitionsBuilder(),
          ),
        ),
  ),
);
