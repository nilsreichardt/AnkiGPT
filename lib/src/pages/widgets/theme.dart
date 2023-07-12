import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF00FF7F),
);
const blackGreen = Color(0xFF001D0E);
const darkGreen = Color(0xFF004723);
const lightGreen = Color(0xFFA8FFD3);
const _fontFamily = 'Ubuntu';

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
  fontFamily: _fontFamily,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: blackGreen,
        displayColor: blackGreen,
        fontFamily: _fontFamily,
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
