import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';
import '../widgets/chrome.dart';

class Skills extends StatelessWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(number: '02', title: Content.skillsTitle),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoUp = constraints.maxWidth >= 720;
              final cards = [
                for (final g in Content.skillGroups) _SkillCard(group: g),
              ];
              if (!twoUp) {
                return Column(
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      if (i > 0) const SizedBox(height: 16),
                      cards[i],
                    ],
                  ],
                );
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      if (i > 0) const SizedBox(width: 16),
                      Expanded(child: cards[i]),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Skill group rendered as a shadcn card with a hover lift.
class _SkillCard extends StatefulWidget {
  final SkillGroup group;
  const _SkillCard({required this.group});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: Tokens.hoverTime,
        curve: Tokens.ease,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        decoration: BoxDecoration(
          boxShadow: _hover ? Tokens.softShadow : null,
          borderRadius: BorderRadius.circular(Tokens.radiusCard),
        ),
        child: ShadCard(
          title: Text(
            widget.group.label,
            style: Type.mono(size: 13, color: pal.blue),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [for (final item in widget.group.items) Tag(item)],
            ),
          ),
        ),
      ),
    );
  }
}
