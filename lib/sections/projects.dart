import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';
import '../widgets/chrome.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(number: '03', title: Content.projectsTitle),
          const SizedBox(height: 40),
          for (var i = 0; i < Content.projects.length; i++) ...[
            if (i > 0) const SizedBox(height: 24),
            _ProjectCard(project: Content.projects[i]),
          ],
        ],
      ),
    );
  }
}

/// Project rendered as a shadcn card: mono kicker, display title,
/// summary, bullet points, tag badges and a code link footer.
class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final p = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => openUrl(p.url),
        child: AnimatedContainer(
          duration: Tokens.hoverTime,
          curve: Tokens.ease,
          decoration: BoxDecoration(
            boxShadow: _hover ? Tokens.softShadow : null,
            borderRadius: BorderRadius.circular(Tokens.radiusCard),
            border: Border.all(
              color: _hover
                  ? pal.blue.withValues(alpha: 0.45)
                  : Colors.transparent,
            ),
          ),
          child: ShadCard(
            title: SelectableText(
              p.title,
              style: Type.display(
                size: MediaQuery.sizeOf(context).width < 640 ? 30 : 38,
                color: pal.ink,
              ),
            ),
            description: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Prose(p.summary, size: 20, color: pal.grey),
            ),
            footer: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(LucideIcons.codeXml, size: 16, color: pal.grey),
                  const SizedBox(width: 8),
                  Text('View code',
                      style: Type.mono(size: 14, color: pal.blue)),
                  const SizedBox(width: 6),
                  Icon(LucideIcons.arrowUpRight,
                      size: 15, color: pal.blue),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final point in p.points)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Icon(Icons.circle,
                                size: 6, color: pal.blue),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SelectableText(
                              point,
                              style:
                                  Type.sans(size: 17, color: pal.ink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [for (final t in p.tags) Tag(t)],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
