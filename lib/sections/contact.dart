import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../data/content.dart';
import '../design/palette.dart';
import '../design/tokens.dart';
import '../design/type.dart';
import '../widgets/chrome.dart';

/// Big centered closing statement: GitHub + LinkedIn CTAs and email.
class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Palette.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 700;
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(number: '04', title: Content.contactTitle),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 64 : 32,
              vertical: wide ? 96 : 64,
            ),
            decoration: BoxDecoration(
              color: pal.wash,
              borderRadius:
                  BorderRadius.circular(Tokens.radiusCard + 6),
            ),
            child: Column(
              children: [
                SelectableText(
                  Content.contactHeadline,
                  textAlign: TextAlign.center,
                  style: Type.display(
                      size: wide ? 60 : 38,
                      spacing: wide ? -1.8 : -1.2,
                      color: pal.ink),
                ),
                const SizedBox(height: 24),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: SelectableText(
                    Content.contactBody,
                    textAlign: TextAlign.center,
                    style: Type.sans(size: 20, color: pal.grey),
                  ),
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CtaPrimary(
                      label: Content.contactCta,
                      icon: LucideIcons.terminal,
                      onTap: () => openUrl(Content.github),
                    ),
                    CtaOutline(
                      label: Content.contactCtaSecondary,
                      icon: LucideIcons.briefcase,
                      onTap: () => openUrl(Content.linkedin),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _EmailLink(
                  label: Content.email,
                  onTap: () => openUrl('mailto:${Content.email}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _EmailLink({required this.label, required this.onTap});

  @override
  State<_EmailLink> createState() => _EmailLinkState();
}

class _EmailLinkState extends State<_EmailLink> {
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
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: Type.mono(
            size: 15,
            color: _hover ? pal.blueHover : pal.blue,
          ),
        ),
      ),
    );
  }
}
