import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/theme.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/views/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeProvider);
        debugPrint("MyApp rebuilt with themeMode: $themeMode");
        return MaterialApp(
          title: 'Serverpod Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const HomeView(),
        );
      },
    );
  }
}
