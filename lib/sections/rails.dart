import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../design/tokens.dart';

/// Slim right rail on very wide screens: back-to-top appears after scrolling.
class Rails extends StatelessWidget {
  final VoidCallback onTop;
  final bool showTop;
  const Rails({super.key, required this.onTop, required this.showTop});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < Tokens.railBreakpoint) {
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        Positioned(
          right: 30,
          top: 0,
          bottom: 0,
          child: Center(
            child: AnimatedOpacity(
              duration: Tokens.hoverTime,
              opacity: showTop ? 1 : 0,
              child: IgnorePointer(
                ignoring: !showTop,
                child: Tooltip(
                  message: 'Back to top',
                  child: ShadIconButton.outline(
                    icon: const Icon(LucideIcons.arrowUp),
                    onPressed: onTop,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
