import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/use_cases/app_use_case.dart';

class FinishWeekButton extends ConsumerWidget {
  const FinishWeekButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finishWeekState = ref.watch(finishWeekMutation);

    return OutlinedButton.icon(
      onPressed: finishWeekState.isPending
          ? null
          : () async {
              String noteText = '';
              final note = await showDialog<String>(
                context: context,
                builder: (_) => StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: const Text('Finish this week?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'How was your week? Share a quick reflection to carry into the next one.',
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            maxLines: 3,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'What felt good? What would you tweak?',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              noteText = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: noteText.trim().isEmpty
                              ? null
                              : () {
                                  context.pop(noteText.trim());
                                },
                          child: const Text('Finish week'),
                        ),
                      ],
                    );
                  },
                ),
              );
              if (note == null) return;
              await finishWeekMutation.run(ref, (tsx) async {
                await ref.read(appUseCaseProvider).finishWeek(note);
              });
            },
      icon: finishWeekState.isPending
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const HugeIcon(icon: HugeIcons.strokeRoundedTick02),
      label: const Text('Finish week'),
    );
  }
}
