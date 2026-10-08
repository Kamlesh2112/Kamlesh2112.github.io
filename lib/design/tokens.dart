import 'package:flutter/material.dart';

/// Mode-independent tokens: layout, shape, motion, depth.
/// Colors live in [Palette] — look them up per build via `Palette.of(context)`.
abstract class Tokens {
  // ── Layout ─────────────────────────────────────────────
  static const maxWidth = 1200.0;
  static const railBreakpoint = 1380.0;
  static const gutter = 32.0;

  // ── Shape ──────────────────────────────────────────────
  static const radiusCard = 22.0;
  static const radiusPill = 999.0;

  // ── Motion ─────────────────────────────────────────────
  static const revealTime = Duration(milliseconds: 700);
  static const hoverTime = Duration(milliseconds: 200);
  static const ease = Curves.easeOutCubic;

  // ── Depth (visible on light; borders carry dark mode) ──
  static const softShadow = [
    BoxShadow(color: Color(0x0F1D1D1F), blurRadius: 24, offset: Offset(0, 8)),
  ];
  static const liftShadow = [
    BoxShadow(color: Color(0x1A1D1D1F), blurRadius: 36, offset: Offset(0, 16)),
  ];
}
