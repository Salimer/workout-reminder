import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/animated_section.dart';
import '../../../../core/widgets/app_card.dart';
import '../../use_cases/profile_use_case.dart';
import '../state/profile_state.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileStateProvider);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: profileAsync.when(
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
                                color: scheme.primary.withValues(alpha: 0.15),
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
                          controller: TextEditingController(
                            text: profile.motivation,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g., "To keep up with my kids"',
                            filled: true,
                            fillColor: scheme.surfaceContainerHighest
                                .withValues(
                                  alpha: 0.3,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.psychology_outlined),
                          ),
                          onSubmitted: (value) {
                            ref
                                .read(profileUseCaseProvider.notifier)
                                .updateMotivation(value);
                          },
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
                          'Goals',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _GoalChip(
                              label: 'Lose fat',
                              isSelected: profile.goals.contains('Lose fat'),
                              onToggle: (selected) =>
                                  _toggleGoal(ref, profile.goals, 'Lose fat'),
                            ),
                            _GoalChip(
                              label: 'Build muscle',
                              isSelected: profile.goals.contains(
                                'Build muscle',
                              ),
                              onToggle: (selected) => _toggleGoal(
                                ref,
                                profile.goals,
                                'Build muscle',
                              ),
                            ),
                            _GoalChip(
                              label: 'Better energy',
                              isSelected: profile.goals.contains(
                                'Better energy',
                              ),
                              onToggle: (selected) => _toggleGoal(
                                ref,
                                profile.goals,
                                'Better energy',
                              ),
                            ),
                            _GoalChip(
                              label: 'Stay consistent',
                              isSelected: profile.goals.contains(
                                'Stay consistent',
                              ),
                              onToggle: (selected) => _toggleGoal(
                                ref,
                                profile.goals,
                                'Stay consistent',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ),
    );
  }

  void _toggleGoal(WidgetRef ref, List<String> currentGoals, String goal) {
    final newGoals = List<String>.from(currentGoals);
    if (newGoals.contains(goal)) {
      newGoals.remove(goal);
    } else {
      newGoals.add(goal);
    }
    ref.read(profileUseCaseProvider.notifier).updateGoals(newGoals);
  }
}

class _GoalChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onToggle;

  const _GoalChip({
    required this.label,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onToggle(!isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? scheme.primary.withValues(alpha: 0.15)
              : scheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? scheme.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? scheme.primary : scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
