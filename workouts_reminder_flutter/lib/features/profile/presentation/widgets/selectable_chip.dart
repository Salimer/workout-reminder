import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onRemove;

  const SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onToggle,
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onToggle(!isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? scheme.primary : scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  // Prevent chip toggle when clicking X.
                  onRemove!();
                },
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedCancelCircle,
                  size: 16,
                  color: isSelected
                      ? scheme.primary
                      : scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
