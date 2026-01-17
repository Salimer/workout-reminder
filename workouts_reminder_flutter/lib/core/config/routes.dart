import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../features/auth/presentation/views/sign_in_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/auth/presentation/views/splash_view.dart';
import '../../features/progress/presentation/views/progress_loader_view.dart';
import '../providers/client.dart';
import '../providers/first_relaunch.dart';

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
        routes: [],
      ),
      GoRoute(
        name: AppRoutes.signIn,
        path: '/sign_in',
        pageBuilder: (context, state) {
          return _adaptivePageBuilder(
            state,
            const SignInView(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.progressLoader,
        path: '/progress_loader',
        pageBuilder: (context, state) {
          return _adaptivePageBuilder(
            state,
            const ProgressLoaderView(),
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
    refreshListenable: ref.read(clientProvider).auth.authInfoListenable,
    redirect: (context, state) {
      if (ref.read(firstRelaunchProvider)) {
        return null;
      }

      final isAuthed = ref.read(clientProvider).auth.isAuthenticated;
      // final isOnSignIn = state.matchedLocation == '/sign_in';
      final isOnSignIn = state.name == AppRoutes.signIn;

      if (!isAuthed && !isOnSignIn) {
        return state.namedLocation(AppRoutes.signIn);
      }
      if (isAuthed && isOnSignIn) {
        return state.namedLocation(AppRoutes.progressLoader);
      }
      return null;
    },
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
  static const String signIn = 'sign_in';
  static const String progressLoader = 'progress_loader';
}
