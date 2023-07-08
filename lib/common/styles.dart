import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.bebasNeue(
      fontSize: 42, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.bebasNeue(
      fontSize: 36, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.bebasNeue(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.alata(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.alata(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.alata(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.openSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.openSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.oxygen(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.oxygen(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.4),
  labelSmall: GoogleFonts.oxygen(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

const ColorScheme myColorScheme = ColorScheme.light(
  primary: Color(0xffBB2828),
  onPrimary: Color(0xffffffff),
  secondary: Color(0xffffffff),
  tertiary: Color(0xFF7A7A7A),
  onSecondary: Color(0xff8c0000),
  surface: Color(0xFFede8e8),
  onSurface: Colors.black87,
  background: Color(0xffe8c5c5),
  onBackground: Color(0xffffffff),
  error: Color(0xffFFF7AE),
  onError: Color(0xffFF0404),
  brightness: Brightness.light,
);
