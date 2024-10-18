import 'package:flutter/material.dart';

const blackGreen = Color(0xFF001D0E);
const darkGreen = Color(0xFF004723);
const lightGreen = Color(0xFFA8FFD3);
const _fontFamily = 'Ubuntu';

final ankigptTheme = ThemeData(
  primaryColor: Colors.white,
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    secondary: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black,
    textTheme: ButtonTextTheme.primary,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
  fontFamily: _fontFamily,
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: _fontFamily,
      ),
  scaffoldBackgroundColor: Colors.black,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: TargetPlatform.values.asMap().map(
          (key, value) => MapEntry(
            value,
            const FadeUpwardsPageTransitionsBuilder(),
          ),
        ),
  ),
);
