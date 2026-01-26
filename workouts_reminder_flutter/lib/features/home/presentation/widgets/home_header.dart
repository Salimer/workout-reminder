import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../state/home_view_state.dart';

class HomeHeader extends ConsumerWidget {
  final VoidCallback onAvatarTap;

  const HomeHeader({
    super.key,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewStateProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${state.greeting},',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                state.userName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedUserCircle,
              size: 28,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
