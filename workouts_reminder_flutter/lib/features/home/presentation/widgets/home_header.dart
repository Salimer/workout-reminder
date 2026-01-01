import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/home_view_model.dart';

class HomeHeader extends ConsumerWidget {
  final VoidCallback onAvatarTap;

  const HomeHeader({
    super.key,
    required this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
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
              image: const DecorationImage(
                image: AssetImage('assets/images/user_avatar_placeholder.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Icon(Icons.person), // Fallback
          ),
        ),
      ],
    );
  }
}
