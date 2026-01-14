import 'package:flutter/material.dart';

import '../../../../core/constants/enums.dart';

class DayStyleModel {
  final Color background;
  final Color border;
  final Color text;
  final Color accent;

  const DayStyleModel({
    required this.background,
    required this.border,
    required this.text,
    required this.accent,
  });

  factory DayStyleModel.fromStatus(
    DayWorkoutStatusEnum status,
    ColorScheme scheme,
  ) {
    switch (status) {
      case DayWorkoutStatusEnum.performed:
        return DayStyleModel(
          background: const Color(0xFF12B76A).withValues(alpha: 0.2),
          border: const Color(0xFF12B76A).withValues(alpha: 0.45),
          text: const Color(0xFF0B7A4B),
          accent: const Color(0xFF12B76A),
        );
      case DayWorkoutStatusEnum.skipped:
        return DayStyleModel(
          background: Colors.red.withValues(alpha: 0.12),
          border: Colors.red.withValues(alpha: 0.25),
          text: Colors.red.shade700,
          accent: Colors.red,
        );
      case DayWorkoutStatusEnum.pending:
        return DayStyleModel(
          background: const Color(0xFF3B82F6).withValues(alpha: 0.16),
          border: const Color(0xFF3B82F6).withValues(alpha: 0.45),
          text: const Color(0xFF1D4ED8),
          accent: const Color(0xFF3B82F6),
        );
      case DayWorkoutStatusEnum.notScheduled:
        return DayStyleModel(
          background: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
          border: scheme.onSurface.withValues(alpha: 0.08),
          text: scheme.onSurface.withValues(alpha: 0.6),
          accent: scheme.onSurface.withValues(alpha: 0.35),
        );
    }
  }
}
