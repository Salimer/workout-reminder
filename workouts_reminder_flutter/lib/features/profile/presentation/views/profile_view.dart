import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/use_cases/app_use_case.dart';
import '../../data/models/goal_model.dart';
import '../../use_cases/profile_use_case.dart';
import '../state/profile_state.dart';
import '../widgets/selectable_chip.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _motivationController;
  late TextEditingController _goalController;
  bool _isInit = true;

  final List<String> _suggestedGoals = [
    'Lose fat',
    'Build muscle',
    'Better energy',
    'Stay consistent',
    'Improve health',
    'Increase flexibility',
  ];

  @override
  void initState() {
    super.initState();
    _motivationController = TextEditingController();
    _goalController = TextEditingController();
  }

  @override
  void dispose() {
    _motivationController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer(
            builder: (context, ref, _) {
              final profileAsync = ref.watch(profileStateProvider);
              final theme = Theme.of(context);
              final scheme = theme.colorScheme;

              // Initialize controller text once when data is first loaded
              if (_isInit && profileAsync.hasValue) {
                _motivationController.text =
                    profileAsync.value?.motivation ?? '';
                _isInit = false;
              }
              return profileAsync.when(
                data: (profile) => ListView(
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
                                    'My Profile',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Set your motivation and goals to help us personalize your nudges.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
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
                                    color: scheme.primary.withValues(
                                      alpha: 0.15,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.person, color: scheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppAnimatedSection(
                      index: 1,
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Motivation',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Why do you show up? We will remind you of this.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _motivationController,
                              maxLines: null,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'e.g., "To keep up with my kids"',
                                filled: true,
                                fillColor: scheme.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                alignLabelWithHint: true,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(bottom: 48),
                                  child: const Icon(Icons.psychology_outlined),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton.icon(
                                onPressed: () {
                                  ref
                                      .read(profileUseCaseProvider.notifier)
                                      .updateMotivation(
                                        _motivationController.text.trim(),
                                      );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Motivation saved!'),
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.check, size: 18),
                                label: const Text('Save'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppAnimatedSection(
                      index: 2,
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Experience Level',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final level in [
                                  'Beginner',
                                  'Intermediate',
                                  'Advanced',
                                ])
                                  SelectableChip(
                                    label: level,
                                    isSelected: profile.fitnessLevel == level,
                                    onToggle: (_) => ref
                                        .read(
                                          profileUseCaseProvider.notifier,
                                        )
                                        .updateFitnessLevel(level),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppAnimatedSection(
                      index: 3,
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coach Persona',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'How should the AI talk to you?',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final tone in [
                                  'Friendly',
                                  'Tough',
                                  'Funny',
                                ])
                                  SelectableChip(
                                    label: tone,
                                    isSelected:
                                        profile.notificationTone == tone,
                                    onToggle: (_) => ref
                                        .read(
                                          profileUseCaseProvider.notifier,
                                        )
                                        .updateNotificationTone(tone),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppAnimatedSection(
                      index: 4,
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Goals',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Add Custom Goal Input
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _goalController,
                                    decoration: InputDecoration(
                                      hintText: 'Add custom goal...',
                                      filled: true,
                                      fillColor: scheme.surfaceContainerHighest
                                          .withValues(alpha: 0.3),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                    ),
                                    onSubmitted: (_) =>
                                        _addCustomGoal(profile.goals, ref),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton.filled(
                                  onPressed: () =>
                                      _addCustomGoal(profile.goals, ref),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Display Current Goals
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                // Suggested goals (if not already in profile.goals, they are just togglable)
                                for (final suggested in _suggestedGoals)
                                  SelectableChip(
                                    label: suggested,
                                    isSelected: profile.goals.any(
                                      (goal) => goal.text == suggested,
                                    ),
                                    onToggle: (_) => _toggleGoal(
                                      ref,
                                      profile.goals,
                                      suggested,
                                    ),
                                  ),
                                // Custom goals (anything in profile.goals that isn't suggested)
                                for (final custom
                                    in profile.goals
                                        .where(
                                          (g) =>
                                              !_suggestedGoals.contains(g.text),
                                        )
                                        .map((goal) => goal.text))
                                  SelectableChip(
                                    label: custom,
                                    isSelected: true,
                                    onRemove: () =>
                                        _removeGoal(ref, profile.goals, custom),
                                    onToggle: (_) => _toggleGoal(
                                      ref,
                                      profile.goals,
                                      custom,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppAnimatedSection(
                      index: 5,
                      child: SizedBox(
                        width: double.infinity,
                        child: Consumer(
                          builder: (context, ref, _) {
                            final mutation = updateProfileMutation;
                            final state = ref.watch(mutation);
                            ref.listen(mutation, (_, next) {
                              if (next.hasError && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error saving profile: ${(next as MutationError).error}',
                                    ),
                                  ),
                                );
                              }
                            });
                            return FilledButton.icon(
                              onPressed: state.isPending
                                  ? null
                                  : () async {
                                      await updateProfileMutation
                                          .run(ref, (tsx) async {
                                            await Future.delayed(
                                              const Duration(milliseconds: 900),
                                            );
                                            await tsx
                                                .get(appUseCaseProvider)
                                                .updateProfile(profile);
                                          })
                                          .then((_) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Profile saved.',
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  duration: Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                            }
                                          })
                                          .catchError((_) {});
                                    },
                              icon: state.isPending
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.save_outlined),
                              label: const Text('Save all changes'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              );
            },
          ),
        ),
      ),
    );
  }

  void _addCustomGoal(List<GoalModel> currentGoals, WidgetRef ref) {
    final goal = _goalController.text.trim();
    final hasGoal = currentGoals.any((g) => g.text == goal);
    if (goal.isNotEmpty && !hasGoal) {
      final newGoals = [...currentGoals, GoalModel(text: goal)];
      ref.read(profileUseCaseProvider.notifier).updateGoals(newGoals);
      _goalController.clear();
    }
  }

  void _removeGoal(WidgetRef ref, List<GoalModel> currentGoals, String goal) {
    final newGoals = currentGoals.where((g) => g.text != goal).toList();
    ref.read(profileUseCaseProvider.notifier).updateGoals(newGoals);
  }

  void _toggleGoal(WidgetRef ref, List<GoalModel> currentGoals, String goal) {
    final newGoals = List<GoalModel>.from(currentGoals);
    final index = newGoals.indexWhere((g) => g.text == goal);
    if (index != -1) {
      newGoals.removeAt(index);
    } else {
      newGoals.add(GoalModel(text: goal));
    }
    ref.read(profileUseCaseProvider.notifier).updateGoals(newGoals);
  }
}
