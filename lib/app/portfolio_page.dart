import 'package:flutter/material.dart';

import '../design/palette.dart';
import '../sections/about.dart';
import '../sections/contact.dart';
import '../sections/footer.dart';
import '../sections/hero.dart' as sections;
import '../sections/projects.dart';
import '../sections/rails.dart';
import '../sections/site_nav.dart';
import '../sections/skills.dart';
import '../widgets/chrome.dart';
import '../widgets/reveal.dart';

/// Assembles the single-page portfolio: nav, hero, sections, rails, footer.
class PortfolioPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  const PortfolioPage(
      {super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();
  final _top = GlobalKey();
  final _keys = {
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  String _active = '';
  double _progress = 0;
  bool _pastFold = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  double? _topOf(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return null;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero).dy;
  }

  void _onScroll() {
    if (!mounted || !_scroll.hasClients) return;
    final max = _scroll.position.maxScrollExtent;
    final offset = _scroll.offset;
    final vh = MediaQuery.sizeOf(context).height;
    final probe = vh * 0.35;

    var current = '';
    for (final entry in _keys.entries) {
      final top = _topOf(entry.value);
      if (top != null && top <= probe) current = entry.key;
    }

    final progress = max <= 0 ? 0.0 : (offset / max).clamp(0.0, 1.0);
    final pastFold = offset > vh * 0.6;
    if (current != _active ||
        progress != _progress ||
        pastFold != _pastFold) {
      setState(() {
        _active = current;
        _progress = progress;
        _pastFold = pastFold;
      });
    }
  }

  void _go(String target) {
    final key = target == 'top' ? _top : _keys[target];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: target == 'top' ? 0.0 : 0.1,
    );
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return Scaffold(
      backgroundColor: pal.paper,
      body: Column(
        children: [
          SiteNav(
            onNavigate: _go,
            active: _active,
            progress: _progress,
            isDark: widget.isDark,
            onToggleTheme: widget.onToggleTheme,
          ),
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  controller: _scroll,
                  child: SingleChildScrollView(
                    controller: _scroll,
                    child: Column(
                      children: [
                        Container(
                          key: _top,
                          child: sections.Hero(
                            onViewProjects: () => _go('projects'),
                            onContact: () => _go('contact'),
                          ),
                        ),
                        Measure(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Reveal(
                                controller: _scroll,
                                child: Container(
                                    key: _keys['about'],
                                    child: const About()),
                              ),
                              Reveal(
                                controller: _scroll,
                                delay:
                                    const Duration(milliseconds: 80),
                                child: Container(
                                    key: _keys['skills'],
                                    child: const Skills()),
                              ),
                              Reveal(
                                controller: _scroll,
                                child: Container(
                                    key: _keys['projects'],
                                    child: const Projects()),
                              ),
                              Reveal(
                                controller: _scroll,
                                delay:
                                    const Duration(milliseconds: 80),
                                child: Container(
                                    key: _keys['contact'],
                                    child: const Contact()),
                              ),
                            ],
                          ),
                        ),
                        Reveal(
                          controller: _scroll,
                          child: Footer(onTop: () => _go('top')),
                        ),
                      ],
                    ),
                  ),
                ),
                Rails(onTop: () => _go('top'), showTop: _pastFold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
