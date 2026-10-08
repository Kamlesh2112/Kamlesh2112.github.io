import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';

/// Centers content at the site's max measure.
class Measure extends StatelessWidget {
  final Widget child;
  const Measure({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Tokens.maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter),
          child: child,
        ),
      ),
    );
  }
}

/// Numbered section heading with a trailing rule — the editorial signature.
class SectionHeading extends StatelessWidget {
  final String number;
  final String title;
  const SectionHeading({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(number, style: Type.mono(size: 16, color: pal.blue)),
        const SizedBox(width: 14),
        Flexible(
          child: SelectableText(
            title,
            style: Type.display(
                size: Type.sectionSize(MediaQuery.sizeOf(context).width),
                color: pal.ink),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(child: Divider(color: pal.hairline, thickness: 1)),
      ],
    );
  }
}

/// Section shell: hairline on top, generous air.
class Section extends StatelessWidget {
  final Widget child;
  const Section({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final pad = MediaQuery.sizeOf(context).width < 640 ? 72.0 : 120.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, thickness: 1, color: pal.hairline),
        Padding(
          padding: EdgeInsets.symmetric(vertical: pad),
          child: child,
        ),
      ],
    );
  }
}

/// Body copy in Inter for a consistent reading texture.
class Prose extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  const Prose(this.text, {super.key, this.size = 20, this.color});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return SelectableText(
      text,
      style: GoogleFonts.inter(
          fontSize: size, height: 1.6, color: color ?? pal.ink),
    );
  }
}

/// Primary call-to-action rendered as a shadcn button.
class CtaPrimary extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  const CtaPrimary({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = LucideIcons.arrowRight,
  });

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: Colors.white),
        ],
      ),
    );
  }
}

/// Secondary call-to-action rendered as a shadcn outline button.
class CtaOutline extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  const CtaOutline({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = LucideIcons.arrowUpRight,
  });

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return ShadButton.outline(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w500, color: pal.ink),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 16, color: pal.ink),
        ],
      ),
    );
  }
}

/// Inline link rendered as a shadcn link button.
class CtaLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CtaLink({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ShadButton.link(onPressed: onTap, child: Text(label));
  }
}

/// Quiet tag rendered as a shadcn secondary badge.
class Tag extends StatelessWidget {
  final String label;
  const Tag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadBadge.secondary(child: Text(label));
  }
}

Future<void> openUrl(String url) async {
  await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
}
