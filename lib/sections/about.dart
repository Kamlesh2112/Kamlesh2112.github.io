import 'package:flutter/material.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';
import '../widgets/chrome.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(number: '01', title: Content.aboutTitle),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: const Prose(Content.aboutBody, size: 22),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final f in Content.focus) _FocusChip(f),
            ],
          ),
          const SizedBox(height: 28),
          const _StatusPill(),
        ],
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  final String label;
  const _FocusChip(this.label);

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: pal.wash,
        borderRadius: BorderRadius.circular(Tokens.radiusPill),
      ),
      child: Text(label, style: Type.mono(size: 14, color: pal.ink)),
    );
  }
}

class _StatusPill extends StatefulWidget {
  const _StatusPill();

  @override
  State<_StatusPill> createState() => _StatusPillState();
}

class _StatusPillState extends State<_StatusPill> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: Tokens.hoverTime,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: _hover ? pal.wash : pal.paper,
          borderRadius: BorderRadius.circular(Tokens.radiusPill),
          border: Border.all(color: pal.hairline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF30D158),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                Content.status,
                style: Type.sans(size: 16, color: pal.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
