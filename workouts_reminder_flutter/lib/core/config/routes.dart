import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/views/home_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../splash.dart';

part 'routes.g.dart';

@Riverpod(keepAlive: true)
GoRouter routes(Ref ref) {
  return GoRouter(
    routes: [
      GoRoute(
        name: AppRoutes.splash,
        path: '/',
        pageBuilder: (context, state) =>
            _adaptivePageBuilder(state, const SplashView()),
      ),
      GoRoute(
        name: AppRoutes.home,
        path: '/home',
        pageBuilder: (context, state) {
          return _adaptivePageBuilder(
            state,
            const HomeView(),
          );
        },
        routes: [
          GoRoute(
            name: AppRoutes.profile,
            path: 'profile',
            pageBuilder: (context, state) {
              return _adaptivePageBuilder(
                state,
                const ProfileView(),
              );
            },
          ),
        ],
      ),
    ],

    // redirect: (context, state) {
    //   // Add your authentication logic here if needed
    //   final session = Supabase.instance.client.auth.currentSession;
    //   if (session == null) {
    //     return '/login';
    //   }
    //   return null; // No redirection by default
    // },
  );
}

/// Helper to adapt page transitions based on platform
Page<void> _adaptivePageBuilder(GoRouterState state, Widget child) {
  return Platform.isIOS
      ? CupertinoPage(child: child, key: state.pageKey)
      : MaterialPage(child: child, key: state.pageKey);
}

class AppRoutes {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String profile = 'profile';
}
