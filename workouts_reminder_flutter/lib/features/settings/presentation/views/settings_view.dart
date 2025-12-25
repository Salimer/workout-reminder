import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/core/services/notifications_service.dart';

import '../../../../core/providers/theme.dart' show themeProvider;
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            AppAnimatedSection(
              index: 0,
              child: AppCard(
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    scheme.primary.withValues(alpha: 0.12),
                    scheme.secondary.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Personalize the look and feel of your workout space.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: scheme.primary.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.tune,
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppAnimatedSection(
              index: 1,
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppAnimatedSection(
              index: 2,
              child: Consumer(
                builder: (context, ref, _) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    final List<PendingNotificationRequest> pending = await ref
                        .read(notificationsSvcProvider)
                        .getPendingNotificationRequests();

                    debugPrint('Pending notifications (${pending.length}):');
                    for (final n in pending) {
                      debugPrint(
                        '- ID: ${n.id}, Title: ${n.title}, Body: ${n.body}, Payload: ${n.payload}',
                      );
                    }

                    // debugPrint(pending.map((n) => n.toString()).join('\n'));
                  });
                  final themeMode = ref.watch(themeProvider);
                  final effectiveDark =
                      MediaQuery.of(context).platformBrightness ==
                      Brightness.dark;

                  return AppCard(
                    padding: const EdgeInsets.all(12),
                    borderRadius: BorderRadius.circular(16),
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
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          themeMode.requireValue == ThemeMode.system
                              ? 'Following system: currently ${effectiveDark ? 'dark' : 'light'}.'
                              : 'Using ${themeMode.requireValue.name} mode.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
