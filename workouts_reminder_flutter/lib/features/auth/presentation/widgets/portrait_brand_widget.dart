import 'package:flutter/material.dart';

import 'logo_badge_widget.dart';

class PortraitBrandWidget extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final ColorScheme scheme;

  const PortraitBrandWidget({
    super.key,
    required this.accent,
    required this.accentSoft,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoBadgeWidget(accent: accent, accentSoft: accentSoft),
        const SizedBox(height: 24),
        Text(
          'Workout Reminder',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Stay consistent, build momentum',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: scheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
