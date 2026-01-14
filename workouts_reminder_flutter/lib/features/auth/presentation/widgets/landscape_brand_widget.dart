import 'package:flutter/material.dart';

import 'logo_badge_widget.dart';

class LandscapeBrandWidget extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final ColorScheme scheme;

  const LandscapeBrandWidget({
    super.key,
    required this.accent,
    required this.accentSoft,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LogoBadgeWidget(
            accent: accent,
            accentSoft: accentSoft,
            size: 96,
            iconSize: 48,
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workout Reminder',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Stay consistent, build momentum',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
