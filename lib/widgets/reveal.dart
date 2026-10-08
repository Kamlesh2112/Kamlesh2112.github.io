import 'package:flutter/material.dart';

import '../design/tokens.dart';

/// Fades and rises once when scrolled into view.
class Reveal extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final Duration delay;
  const Reveal({
    super.key,
    required this.controller,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _inView = false;
  bool _shown = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didUpdateWidget(Reveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_check);
      widget.controller.addListener(_check);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_check);
    super.dispose();
  }

  void _check() {
    if (_inView || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    if (box.localToGlobal(Offset.zero).dy <
        MediaQuery.sizeOf(context).height * 0.92) {
      _inView = true;
      widget.controller.removeListener(_check);
      if (widget.delay == Duration.zero) {
        setState(() => _shown = true);
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) setState(() => _shown = true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: _shown ? 1 : 0),
      duration: Tokens.revealTime,
      curve: Tokens.ease,
      builder: (context, t, child) => Opacity(
        opacity: t.clamp(0.0, 1.0),
        child:
            Transform.translate(offset: Offset(0, 28 * (1 - t)), child: child),
      ),
      child: widget.child,
    );
  }
}
