import 'package:flutter/material.dart';

/// Mode-aware color palette. Neutrals follow Apple HIG in both modes;
/// components come from shadcn_ui (blue color scheme).
/// Read via `Palette.of(context)` — never cache it across theme changes.
class Palette {
  final Brightness brightness;
  final Color paper;
  final Color ink;
  final Color grey;
  final Color blue;
  final Color blueHover;
  final Color hairline;
  final Color hairlineSoft;
  final Color wash;
  final Color ghost;
  final Color green;
  final Color heart;
  final Color veil;

  const Palette._({
    required this.brightness,
    required this.paper,
    required this.ink,
    required this.grey,
    required this.blue,
    required this.blueHover,
    required this.hairline,
    required this.hairlineSoft,
    required this.wash,
    required this.ghost,
    required this.green,
    required this.heart,
    required this.veil,
  });

  static const light = Palette._(
    brightness: Brightness.light,
    paper: Color(0xFFFFFFFF),
    ink: Color(0xFF1D1D1F),
    grey: Color(0xFF6E6E73),
    blue: Color(0xFF0071E3),
    blueHover: Color(0xFF0077ED),
    hairline: Color(0xFFE5E5EA),
    hairlineSoft: Color(0xFFF1F1F3),
    wash: Color(0xFFF5F5F7),
    ghost: Color(0xFFEEEEF0),
    green: Color(0xFF34C759),
    heart: Color(0xFFFF375F),
    veil: Color(0xB3FFFFFF),
  );

  static const dark = Palette._(
    brightness: Brightness.dark,
    paper: Color(0xFF000000),
    ink: Color(0xFFF5F5F7),
    grey: Color(0xFFA1A1A6),
    blue: Color(0xFF0A84FF),
    blueHover: Color(0xFF409CFF),
    hairline: Color(0xFF2C2C2E),
    hairlineSoft: Color(0xFF1D1D1F),
    wash: Color(0xFF1C1C1E),
    ghost: Color(0xFF161618),
    green: Color(0xFF30D158),
    heart: Color(0xFFFF375F),
    veil: Color(0xB3000000),
  );

  bool get isDark => brightness == Brightness.dark;

  static Palette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
