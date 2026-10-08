import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';
import '../widgets/chrome.dart';

/// Full-bleed hero: mono greeting, oversized name with a blue full stop.
class Hero extends StatefulWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;
  const Hero(
      {super.key, required this.onViewProjects, required this.onContact});

  @override
  State<Hero> createState() => _HeroState();
}

class _HeroState extends State<Hero> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _in(double start, double end, Widget child) {
    final a = CurvedAnimation(
      parent: _c,
      curve: Interval(start, end, curve: Tokens.ease),
    );
    return FadeTransition(
      opacity: a,
      child: SlideTransition(
        position:
            Tween(begin: const Offset(0, 0.10), end: Offset.zero).animate(a),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 900;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -90,
          right: wide ? -40 : -160,
          child: IgnorePointer(
            child: Container(
              width: wide ? 480 : 260,
              height: wide ? 480 : 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    pal.blue.withValues(alpha: 0.08),
                    pal.blue.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: wide ? 140 : 84, bottom: wide ? 120 : 84),
          child: Measure(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _in(
                  0.00,
                  0.45,
                  Text(Content.greeting,
                      style: Type.mono(size: 17, color: pal.blue)),
                ),
                const SizedBox(height: 24),
                _in(
                  0.08,
                  0.60,
                  SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: Content.name),
                        TextSpan(
                            text: '.',
                            style: TextStyle(color: pal.blue)),
                      ],
                      style: Type.display(
                          size: Type.heroSize(width), color: pal.ink),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _in(
                  0.14,
                  0.68,
                  SelectableText(
                    Content.role,
                    style: Type.display(
                      size: width < 640 ? 26 : 32,
                      weight: FontWeight.w600,
                      color: pal.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: _in(
                    0.20,
                    0.78,
                    Prose(Content.intro, size: 22, color: pal.grey),
                  ),
                ),
                const SizedBox(height: 44),
                _in(
                  0.30,
                  0.95,
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      CtaPrimary(
                          label: 'View projects',
                          icon: LucideIcons.arrowRight,
                          onTap: widget.onViewProjects),
                      CtaLink(
                          label: 'Get in touch',
                          onTap: widget.onContact),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _in(
                  0.40,
                  1.0,
                  Row(
                    children: [
                      Icon(LucideIcons.mapPin, size: 14, color: pal.grey),
                      const SizedBox(width: 8),
                      Text(Content.location,
                          style: Type.mono(size: 13, color: pal.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
