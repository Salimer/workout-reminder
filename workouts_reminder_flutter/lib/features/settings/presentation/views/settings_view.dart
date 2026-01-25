import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workouts_reminder_flutter/features/schedule/use_cases/notifications_use_case.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/providers/theme.dart' show themeProvider;
import '../../../../core/use_cases/app_use_case.dart';
import '../../../../core/widgets/animated_section.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/routes.dart';
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
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedSettings02,
                        color: scheme.primary,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppAnimatedSection(
              index: 1,
              child: AppCard(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(16),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedUser,
                      color: scheme.primary,
                      size: 20,
                    ),
                  ),
                  title: const Text('My Profile'),
                  subtitle: const Text('Goals & Motivation'),
                  trailing: const HugeIcon(
                    icon: HugeIcons.strokeRoundedArrowRight01,
                    size: 18,
                  ),
                  onTap: () {
                    context.goNamed(AppRoutes.profile);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppAnimatedSection(
              index: 3,
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppAnimatedSection(
              index: 4,
              child: Consumer(
                builder: (context, ref, _) {
                  final themeMode = ref.watch(themeProvider);
                  final effectiveDark =
                      MediaQuery.of(context).platformBrightness ==
                      Brightness.dark;

                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    debugPrint("I am here");
                    final notifications = await ref
                        .read(notificationsUseCaseProvider)
                        .getPendingNotifications();

                    debugPrint("not length ${notifications.length}");

                    for (final not in notifications) {
                      debugPrint("notificatoin title: ${not.title!}");
                      debugPrint("notification time: ${not.payload}");
                    }
                  });

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
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedSmartPhone01,
                              ),
                              label: Text('System'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedSun01,
                              ),
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedMoon02,
                              ),
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
            const SizedBox(height: 20),
            AppAnimatedSection(
              index: 5,
              child: Text(
                'Account',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppAnimatedSection(
              index: 6,
              child: Consumer(
                builder: (context, ref, _) {
                  return AppCard(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(16),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: scheme.error.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedLogout03,
                          color: scheme.error,
                          size: 20,
                        ),
                      ),
                      title: const Text('Sign out'),
                      subtitle: const Text('End this session on this device'),
                      onTap: () async {
                        final shouldSignOut = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Sign out?'),
                              content: const Text(
                                'You will need to sign in again to access your workouts.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    dialogContext.pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    dialogContext.pop(true);
                                  },
                                  child: const Text('Sign out'),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldSignOut == true && context.mounted) {
                          await ref.read(appUseCaseProvider).signOut();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            AppAnimatedSection(
              index: 7,
              child: Consumer(
                builder: (context, ref, _) {
                  return AppCard(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(16),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: scheme.error.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedDelete02,
                          color: scheme.error,
                          size: 20,
                        ),
                      ),
                      title: const Text('Delete account'),
                      subtitle: const Text('Permanently remove your data'),
                      onTap: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Delete account?'),
                              content: const Text(
                                'This action cannot be undone.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    dialogContext.pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    dialogContext.pop(true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldDelete == true && context.mounted) {
                          await ref.read(appUseCaseProvider).deleteAccount();
                        }
                      },
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
