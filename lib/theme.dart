import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiteColors {
  static const paper = Color(0xFFF4F6F8);
  static const paperDeep = Color(0xFFE8EDF2);
  static const ink = Color(0xFF15202B);
  static const inkSoft = Color(0xFF4A5563);
  static const line = Color(0xFFC9D2DC);
  static const accent = Color(0xFF245B6B);
  static const accentSoft = Color(0xFFD7E6EA);
}

ThemeData buildSiteTheme() {
  TextTheme display;
  TextTheme body;
  try {
    display = GoogleFonts.libreBaskervilleTextTheme();
    body = GoogleFonts.sourceSans3TextTheme();
  } catch (_) {
    // Offline / font CDN failure — still paint the site.
    display = ThemeData.light().textTheme;
    body = ThemeData.light().textTheme;
  }

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: SiteColors.paper,
    colorScheme: const ColorScheme.light(
      primary: SiteColors.accent,
      onPrimary: Colors.white,
      surface: SiteColors.paper,
      onSurface: SiteColors.ink,
      outline: SiteColors.line,
    ),
    textTheme: body
        .copyWith(
          displayLarge: display.displayLarge?.copyWith(
            color: SiteColors.ink,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1.05,
          ),
          displayMedium: display.displayMedium?.copyWith(
            color: SiteColors.ink,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
          headlineLarge: display.headlineLarge?.copyWith(
            color: SiteColors.ink,
            fontWeight: FontWeight.w600,
            height: 1.15,
          ),
          headlineMedium: display.headlineMedium?.copyWith(
            color: SiteColors.ink,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: body.titleLarge?.copyWith(
            color: SiteColors.ink,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
          bodyLarge: body.bodyLarge?.copyWith(
            color: SiteColors.inkSoft,
            height: 1.55,
            fontSize: 17,
          ),
          bodyMedium: body.bodyMedium?.copyWith(
            color: SiteColors.inkSoft,
            height: 1.5,
          ),
          labelLarge: body.labelLarge?.copyWith(
            color: SiteColors.accent,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        )
        .apply(
          bodyColor: SiteColors.inkSoft,
          displayColor: SiteColors.ink,
        ),
  );
}
