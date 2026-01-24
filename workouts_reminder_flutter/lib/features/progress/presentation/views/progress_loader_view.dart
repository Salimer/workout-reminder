import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/views/home_view.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../state/progress_state.dart';

class ProgressLoaderView extends StatelessWidget {
  const ProgressLoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final progress = ref.watch(progressStateProvider);
        return Material(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            child: progress.when(
              data: (_) {
                return const HomeView();
              },
              error: (e, _) {
                return Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud_off_outlined,
                            size: 48,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Could not load your progress.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            e.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: () {
                              ref.invalidate(progressStateProvider);
                            },
                            child: const Text('Try again'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () {
                return const Scaffold(
                  body: LoadingWidget(
                    message: 'Loading your progress...',
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
