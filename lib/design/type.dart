import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

/// Typography: San Francisco on Apple devices, Inter elsewhere for prose,
/// JetBrains Mono for technical accents (numbers, eyebrows, labels).
/// Colors default to `null` so text inherits the active theme (light/dark).
abstract class Type {
  static const _sans = '.SF Pro Text';
  static const _display = '.SF Pro Display';
  static const _sansFallback = ['Inter', 'Helvetica Neue', 'Arial', 'sans-serif'];

  static TextStyle display({
    double size = 48,
    FontWeight weight = FontWeight.w700,
    Color? color,
    double height = 1.06,
    double? spacing,
  }) {
    return TextStyle(
      fontFamily: _display,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing ?? size * -0.028,
    );
  }

  static TextStyle sans({
    double size = 19,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double height = 1.55,
    double? spacing,
  }) {
    return TextStyle(
      fontFamily: _sans,
      fontFamilyFallback: _sansFallback,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: spacing,
    );
  }

  static TextStyle mono({
    double size = 14,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double? spacing,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: spacing ?? 0.2,
    );
  }

  /// Responsive hero scale.
  static double heroSize(double width) {
    if (width < 420) return 50;
    if (width < 640) return 68;
    if (width < 1000) return 94;
    return 112;
  }

  static double sectionSize(double width) => width < 640 ? 36 : 48;

  /// Merges our reading type + husbands shadcn's base theme with the palette.
  static ThemeData merge(ThemeData base, Palette pal) {
    final inter = GoogleFonts.interTextTheme(base.textTheme);
    return base.copyWith(
      scaffoldBackgroundColor: pal.paper,
      dividerColor: pal.hairline,
      splashFactory: InkSparkle.splashFactory,
      textTheme: inter.copyWith(
        bodyLarge: inter.bodyLarge?.copyWith(color: pal.ink, height: 1.55),
        bodyMedium: inter.bodyMedium?.copyWith(color: pal.ink, height: 1.55),
        bodySmall: inter.bodySmall?.copyWith(color: pal.grey),
        titleMedium: inter.titleMedium?.copyWith(color: pal.ink),
      ),
      iconTheme: IconThemeData(size: 18, color: pal.grey),
      scrollbarTheme: const ScrollbarThemeData(
        thickness: WidgetStatePropertyAll(8),
        radius: Radius.circular(999),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: pal.blue,
        selectionColor: pal.blue.withValues(alpha: 0.2),
        selectionHandleColor: pal.blue,
      ),
    );
  }
}
