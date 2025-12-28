import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/features/home/use_cases/bottom_navigation_use_case.dart';

import 'core/config/routes.dart';
import 'features/schedule/presentation/state/progress.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final progress = await ref.read(progressProvider.future);

      await Future.delayed(const Duration(seconds: 5));

      // If the week schedule is outdated, you can handle it here
      // For example, navigate to the schedule setup view
      // If it's valid, navigate to the main view
      if (progress.activeWeek == null) {
        ref.read(bottomNavigationUseCaseProvider).goToProgressView();
      }
      ref
          .read(routesProvider)
          .goNamed(
            AppRoutes.home,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    final accent = scheme.primary;
    final accentSoft = scheme.secondary;
    final isDark = scheme.brightness == Brightness.dark;
    final isLandscape = size.width > size.height;
    final blobBase = size.shortestSide;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF0C1F17) : const Color(0xFFF2FBF6),
              isDark ? const Color(0xFF0F3526) : const Color(0xFFE9F7F0),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -blobBase * 0.2,
              right: -blobBase * 0.1,
              child: _GlowBlob(
                size: blobBase * 0.7,
                color: accent.withValues(alpha: 0.22),
              ),
            ),
            Positioned(
              bottom: -blobBase * 0.25,
              left: -blobBase * 0.15,
              child: _GlowBlob(
                size: blobBase * 0.75,
                color: accentSoft.withValues(alpha: 0.18),
              ),
            ),
            Center(
              child: isLandscape
                  ? _LandscapeBrand(
                      accent: accent,
                      accentSoft: accentSoft,
                      scheme: scheme,
                    )
                  : _PortraitBrand(
                      accent: accent,
                      accentSoft: accentSoft,
                      scheme: scheme,
                    ),
            ),
            Positioned(
              left: isLandscape ? null : 24,
              right: isLandscape ? 32 : 24,
              bottom: isLandscape ? 28 : 40,
              child: _SplashFooter(
                accent: accent,
                scheme: scheme,
                alignEnd: isLandscape,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortraitBrand extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final ColorScheme scheme;

  const _PortraitBrand({
    required this.accent,
    required this.accentSoft,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LogoBadge(accent: accent, accentSoft: accentSoft),
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

class _LandscapeBrand extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final ColorScheme scheme;

  const _LandscapeBrand({
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
          _LogoBadge(
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

class _SplashFooter extends StatelessWidget {
  final Color accent;
  final ColorScheme scheme;
  final bool alignEnd;

  const _SplashFooter({
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

class _LogoBadge extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final double size;
  final double iconSize;

  const _LogoBadge({
    required this.accent,
    required this.accentSoft,
    this.size = 110,
    this.iconSize = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent,
            accentSoft,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Icon(
        Icons.fitness_center_rounded,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowBlob({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
