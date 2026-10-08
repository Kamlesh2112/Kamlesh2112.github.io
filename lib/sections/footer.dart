import 'package:flutter/material.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';

/// Quiet close: credit lines with a heart icon + back-to-top control.
class Footer extends StatelessWidget {
  final VoidCallback onTop;
  const Footer({super.key, required this.onTop});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final year = DateTime.now().year;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: pal.hairline)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        children: [
          Text(
            Content.designedBy,
            textAlign: TextAlign.center,
            style: Type.mono(size: 14, color: pal.grey),
          ),
          const SizedBox(height: 12),
          Text(
            '© $year ${Content.name}',
            textAlign: TextAlign.center,
            style: Type.mono(size: 14, color: pal.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Content.madeWith,
                style: Type.mono(size: 14, color: pal.grey),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.favorite_rounded,
                  size: 15, color: Color(0xFFFF375F)),
              const SizedBox(width: 6),
              Text(
                Content.madeWithSuffix,
                style: Type.mono(size: 14, color: pal.grey),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _TopButton(onTap: onTop),
        ],
      ),
    );
  }
}

class _TopButton extends StatefulWidget {
  final VoidCallback onTap;
  const _TopButton({required this.onTap});

  @override
  State<_TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<_TopButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Tokens.hoverTime,
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _hover ? pal.wash : Colors.transparent,
            borderRadius: BorderRadius.circular(Tokens.radiusPill),
            border: Border.all(color: pal.hairline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.keyboard_arrow_up_rounded,
                size: 19,
                color: _hover ? pal.ink : pal.grey,
              ),
              const SizedBox(width: 6),
              Text(
                'Back to top',
                style: Type.sans(
                  size: 15,
                  weight: FontWeight.w500,
                  color: _hover ? pal.ink : pal.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
