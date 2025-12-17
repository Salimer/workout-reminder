import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme.dart' show themeProvider;

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Appearance',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Consumer(
          builder: (context, ref, _) {
            final themeMode = ref.watch(themeProvider);
            final effectiveDark =
                MediaQuery.of(context).platformBrightness == Brightness.dark;

            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: Icon(Icons.phone_iphone),
                          label: Text('System'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: Icon(Icons.wb_sunny_outlined),
                          label: Text('Light'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.nights_stay_outlined),
                          label: Text('Dark'),
                        ),
                      ],
                      selected: {themeMode.requireValue},
                      onSelectionChanged: (modes) {
                        final mode = modes.first;
                        ref.read(themeProvider.notifier).setThemeMode(mode);
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      themeMode == ThemeMode.system
                          ? 'Following system: currently ${effectiveDark ? 'dark' : 'light'}.'
                          : 'Using ${themeMode.requireValue.name} mode.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
