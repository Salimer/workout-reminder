import 'package:flutter/material.dart';

class LogoBadgeWidget extends StatelessWidget {
  final Color accent;
  final Color accentSoft;
  final double size;
  final double iconSize;

  const LogoBadgeWidget({
    super.key,
    required this.accent,
    required this.accentSoft,
    this.size = 110,
    this.iconSize = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent,
            accentSoft,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Icon(
        Icons.fitness_center_rounded,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }
}
