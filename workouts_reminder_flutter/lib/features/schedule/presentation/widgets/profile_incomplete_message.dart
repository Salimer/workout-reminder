import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/widgets/animated_section.dart';

class ProfileIncompleteMessage extends StatelessWidget {
  const ProfileIncompleteMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAnimatedSection(
              index: 0,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserEdit01,
                  color: scheme.primary,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppAnimatedSection(
              index: 1,
              child: Text(
                'Complete Your Profile First',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            AppAnimatedSection(
              index: 2,
              child: Text(
                'Before creating your workout schedule, please complete your profile with your motivations and goals. This helps us personalize your experience.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            AppAnimatedSection(
              index: 3,
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    context.goNamed(AppRoutes.profile);
                  },
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedUserEdit01,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text('Complete Profile'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
