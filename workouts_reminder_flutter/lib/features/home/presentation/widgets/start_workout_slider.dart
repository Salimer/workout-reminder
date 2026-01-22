import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartWorkoutSlider extends ConsumerStatefulWidget {
  const StartWorkoutSlider({
    super.key,
    required this.onTriggered,
    this.isLoading = false,
  });

  final Future<void> Function(WidgetRef ref) onTriggered;
  final bool isLoading;

  @override
  ConsumerState<StartWorkoutSlider> createState() =>
      _StartWorkoutSliderState();
}

class _StartWorkoutSliderState extends ConsumerState<StartWorkoutSlider> {
  double _value = 0;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isBusy = widget.isLoading || _isRunning;
    final label = widget.isLoading
        ? 'Updating...'
        : _isRunning
        ? 'Starting...'
        : 'Slide to start workout';

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: scheme.primary.withValues(alpha: 0.12),
            border: Border.all(
              color: scheme.primary.withValues(alpha: 0.3),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 64,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 18),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28),
            activeTrackColor: scheme.primary,
            inactiveTrackColor: Colors.transparent,
            thumbColor: scheme.primary,
          ),
          child: Slider(
            value: _value,
            onChanged: isBusy
                ? null
                : (next) {
                    setState(() {
                      _value = next;
                    });
                  },
            onChangeEnd: isBusy
                ? null
                : (next) async {
                    if (next < 0.95) {
                      setState(() => _value = 0);
                      return;
                    }
                    setState(() {
                      _isRunning = true;
                      _value = 1;
                    });
                    HapticFeedback.mediumImpact();
                    await Future.delayed(const Duration(milliseconds: 300));
                    await widget.onTriggered(ref);
                    if (!mounted) return;
                    setState(() {
                      _isRunning = false;
                      _value = 0;
                    });
                  },
          ),
        ),
      ],
    );
  }
}
