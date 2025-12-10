import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: AppTheme.lightTheme,
      home: const HomeView(),
    );
  }
}
