import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppPalette.white,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppPalette.black,
    ),
    appBarTheme:
        const AppBarTheme(backgroundColor: AppPalette.white, elevation: 0),
    textTheme: GoogleFonts.poppinsTextTheme());

final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppPalette.black,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppPalette.white,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppPalette.black),
    textTheme: GoogleFonts.poppinsTextTheme());
