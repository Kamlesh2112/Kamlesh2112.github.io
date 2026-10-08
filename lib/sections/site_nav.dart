import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';

/// Frosted top nav: name left, mono-numbered links, theme toggle,
/// blue scroll-progress hairline.
class SiteNav extends StatelessWidget {
  final void Function(String target) onNavigate;
  final String active;
  final double progress;
  final bool isDark;
  final VoidCallback onToggleTheme;
  const SiteNav({
    super.key,
    required this.onNavigate,
    required this.active,
    required this.progress,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final narrow = MediaQuery.sizeOf(context).width < 720;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: pal.veil,
            border: Border(bottom: BorderSide(color: pal.hairline)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: Tokens.maxWidth),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: _Brand(onTap: () => onNavigate('top')),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!narrow)
                              for (final link in Content.nav)
                                _NavLink(
                                  link: link,
                                  active: active == link.target,
                                  onTap: () => onNavigate(link.target),
                                ),
                            if (!narrow) const SizedBox(width: 8),
                            _ThemeToggle(
                                isDark: isDark, onToggle: onToggleTheme),
                            if (narrow) ...[
                              const SizedBox(width: 4),
                              _Menu(onNavigate: onNavigate),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(height: 2, color: pal.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  final VoidCallback onTap;
  const _Brand({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          Content.name,
          overflow: TextOverflow.ellipsis,
          style: Type.display(
              size: 18,
              weight: FontWeight.w600,
              spacing: -0.3,
              color: pal.ink),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  const _ThemeToggle({required this.isDark, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: ShadIconButton.ghost(
        icon: Icon(isDark ? LucideIcons.sun : LucideIcons.moon),
        onPressed: onToggle,
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final NavLink link;
  final bool active;
  final VoidCallback onTap;
  const _NavLink({required this.link, required this.active, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final on = _hover || widget.active;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.link.number,
                    style: Type.mono(size: 12, color: pal.blue),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.link.label,
                    style: Type.sans(
                      size: 15,
                      weight: widget.active ? FontWeight.w600 : FontWeight.w400,
                      color: on ? pal.ink : pal.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: Tokens.hoverTime,
                curve: Tokens.ease,
                height: 2,
                width: on ? 20 : 0,
                decoration: BoxDecoration(
                  color: pal.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  final void Function(String) onNavigate;
  const _Menu({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return PopupMenuButton<String>(
      tooltip: 'Menu',
      color: pal.paper,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: pal.hairline),
      ),
      onSelected: onNavigate,
      itemBuilder: (_) => Content.nav
          .map(
            (l) => PopupMenuItem(
              value: l.target,
              height: 48,
              child: Row(
                children: [
                  Text(l.number,
                      style: Type.mono(size: 12, color: pal.blue)),
                  const SizedBox(width: 10),
                  Text(l.label,
                      style: Type.sans(size: 16, color: pal.ink)),
                ],
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: pal.wash,
          borderRadius: BorderRadius.circular(Tokens.radiusPill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Menu',
                style: Type.sans(
                    size: 15, weight: FontWeight.w500, color: pal.ink)),
            const SizedBox(width: 4),
            Icon(Icons.expand_more_rounded, size: 16, color: pal.grey),
          ],
        ),
      ),
    );
  }
}
