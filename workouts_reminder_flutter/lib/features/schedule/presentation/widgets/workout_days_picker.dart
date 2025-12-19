import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';

class WorkoutDaysPicker extends StatefulWidget {
  final Set<WeekdayEnum> initialSelectedDays;
  final Future<void> Function(Set<WeekdayEnum> selectedDays) onSave;

  const WorkoutDaysPicker({
    super.key,
    required this.onSave,
    this.initialSelectedDays = const {},
  });

  @override
  State<WorkoutDaysPicker> createState() => _WorkoutDaysPickerState();
}

class _WorkoutDaysPickerState extends State<WorkoutDaysPicker> {
  late final Set<WeekdayEnum> _selectedDays = {...widget.initialSelectedDays};
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canSave = _selectedDays.isNotEmpty && !_isSaving;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick your workout days',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We’ll schedule 3 reminders per selected day: morning, afternoon, and evening.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final day in WeekdayEnum.values)
                        FilterChip(
                          label: Text(day.day),
                          selected: _selectedDays.contains(day),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(day);
                              } else {
                                _selectedDays.remove(day);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: canSave
                          ? () async {
                              setState(() => _isSaving = true);
                              try {
                                await widget.onSave({..._selectedDays});
                              } finally {
                                if (mounted) setState(() => _isSaving = false);
                              }
                            }
                          : null,
                      child: _isSaving
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Create schedule'),
                    ),
                  ),
                  if (_selectedDays.isEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Select at least one day to continue.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

