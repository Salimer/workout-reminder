import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/routes.dart';
import 'core/providers/theme.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/network_status_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return MaterialApp.router(
          title: 'Serverpod Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ref.read(themeProvider).requireValue,
          routerConfig: ref.read(routesProvider),
          builder: (context, child) {
            return NetworkStatusWidget(child: child ?? const SizedBox.shrink());
          },
        );
      },
    );
  }
}
