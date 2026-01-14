import 'package:flutter/material.dart';

class SplashFooterWidget extends StatelessWidget {
  final Color accent;
  final ColorScheme scheme;
  final bool alignEnd;

  const SplashFooterWidget({
    super.key,
    required this.accent,
    required this.scheme,
    required this.alignEnd,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = alignEnd
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.center;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment,
      children: [
        SizedBox(
          width: 140,
          child: LinearProgressIndicator(
            minHeight: 6,
            backgroundColor: scheme.onSurface.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(accent),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Warming up your plan',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: alignEnd ? TextAlign.right : TextAlign.center,
        ),
      ],
    );
  }
}
