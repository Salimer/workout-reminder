import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../../core/config/routes.dart';
import '../../../../core/providers/client.dart';
import '../../../../core/providers/first_relaunch.dart';
import '../../../../core/services/notifications_service.dart';
import '../widgets/glow_blob_widget.dart';
import '../widgets/landscape_brand_widget.dart';
import '../widgets/portrait_brand_widget.dart';
import '../widgets/splash_footer_widget.dart';

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
      ref.read(firstRelaunchProvider.notifier).setFalse();
      debugPrint("SplashView: Checking authentication");

      await _startInitializers();
      if (mounted) {
        _handleFirstNav();
      }
    });
  }

  Future<void> _startInitializers() async {
    try {
      await Future.wait([
        Future.delayed(const Duration(seconds: 2)),
        ref.read(clientProvider).auth.initialize(),
        ref.read(notificationsSvcProvider).initialize(),
      ]);
    } catch (_) {}
  }

  void _handleFirstNav() {
    final isAuthenticated = ref.read(clientProvider).auth.isAuthenticated;
    if (!isAuthenticated) {
      ref
          .read(routesProvider)
          .goNamed(
            AppRoutes.signIn,
          );
    } else {
      ref
          .read(routesProvider)
          .goNamed(
            AppRoutes.progressLoader,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch(progressStateProvider);

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
              child: GlowBlobWidget(
                size: blobBase * 0.7,
                color: accent.withValues(alpha: 0.22),
              ),
            ),
            Positioned(
              bottom: -blobBase * 0.25,
              left: -blobBase * 0.15,
              child: GlowBlobWidget(
                size: blobBase * 0.75,
                color: accentSoft.withValues(alpha: 0.18),
              ),
            ),
            Center(
              child: isLandscape
                  ? LandscapeBrandWidget(
                      accent: accent,
                      accentSoft: accentSoft,
                      scheme: scheme,
                    )
                  : PortraitBrandWidget(
                      accent: accent,
                      accentSoft: accentSoft,
                      scheme: scheme,
                    ),
            ),
            Positioned(
              left: isLandscape ? null : 24,
              right: isLandscape ? 32 : 24,
              bottom: isLandscape ? 28 : 40,
              child: SplashFooterWidget(
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
